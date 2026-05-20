class AocCli < Formula
  desc "Advent of Code CLI"
  homepage "https://github.com/ahacop/aoc-cli"
  version "0.3.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ahacop/aoc-cli/releases/download/v0.3.0/aoc-cli-aarch64-apple-darwin.tar.xz"
    sha256 "e2356412b85e3e45166014381fe2631037fc2d0ef1519c8e48a9f4d963de0898"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.3.0/aoc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09a4b29d1d6add9cbea1d1be0ff1a6d4ea8a9fc244e91c402b2f62ef1c9cba2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.3.0/aoc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "796a7ea4c0354941239e08645fcea5ac9cbb760883a003e621b7ed28ae273d9f"
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
