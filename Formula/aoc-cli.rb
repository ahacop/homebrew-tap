class AocCli < Formula
  desc "Advent of Code CLI"
  homepage "https://github.com/ahacop/aoc-cli"
  version "0.4.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ahacop/aoc-cli/releases/download/v0.4.0/aoc-cli-aarch64-apple-darwin.tar.xz"
    sha256 "85fe3eb40ca34d9fccd0d361d5a5beb9aa868cf02e4a7bc54137686653881c7c"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.4.0/aoc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b603a6be37203d8ef4f2e2c0d93346c03777242a7094e4b9f870d67f1cb875b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.4.0/aoc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "789dc43012babb1019434e134aaf25a1464e16f2b1edd8e8b874e62dd24580ed"
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
