class AocCli < Formula
  desc "Advent of Code CLI"
  homepage "https://github.com/ahacop/aoc-cli"
  version "0.5.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.1/aoc-cli-aarch64-apple-darwin.tar.xz"
    sha256 "c508c090809767728b8f4d08bed37596b1fc08c7ecffbe00861712a45fb39028"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.1/aoc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b947eb5b84228cc05b83831b20df8b1ca08ad6d44209895aec327093961445e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.1/aoc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd0c28b63bb767968b02bad8c084479fdd07b9003ed0ef3d01d4734845983d90"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "aoc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "aoc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aoc"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
