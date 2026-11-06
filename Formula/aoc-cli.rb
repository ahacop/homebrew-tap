class AocCli < Formula
  desc "Advent of Code CLI"
  homepage "https://github.com/ahacop/aoc-cli"
  version "0.5.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.3/aoc-cli-aarch64-apple-darwin.tar.xz"
    sha256 "11cd869e95fb8b5d3dd91e677549521733219c3eb8b2ebec7dd929ae4bee5503"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.3/aoc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0d0aef008f160e4b4766804f33bdf93a176c22ecbcbed6f01ec0b5fa7f0199c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/aoc-cli/releases/download/v0.5.3/aoc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2101f707609a7e072ee0cd2042f0193074a62f841f16c44a0872f0ee9752b37b"
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
