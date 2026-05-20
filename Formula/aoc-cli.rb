class AocCli < Formula
  desc "Advent of Code CLI"
  homepage "https://github.com/ahacop/aoc-cli"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ahacop/aoc-cli/releases/download/v0.2.0/aoc-cli-aarch64-apple-darwin.tar.xz"
    sha256 "7410b0e528f4c8b8af6bd8d882b7ca5e8c458da129578a3a3260dd0803018a32"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.2.0/aoc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0483b2831ea0967eaf2e866b7c1e3e2ca9c4d0c2f180c0fff41d7e43f2599460"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.2.0/aoc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ccb1e78a8a113ae0e052b37821828ac7c6174cea8762535d015943e5aac2914"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "aoc" if OS.mac? && Hardware::CPU.arm?
    bin.install "aoc" if OS.linux? && Hardware::CPU.arm?
    bin.install "aoc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
