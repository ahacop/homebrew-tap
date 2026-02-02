class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  version "0.9.9"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.9/erwindb-aarch64-apple-darwin.tar.xz"
      sha256 "44ca518749133e0122f4a4e942545c9b70982909c652dd99753dbe5bb7842a13"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.9/erwindb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "29a037f1f5c3100a6c6d317d0ec56b49a8f67a22bfb5f52172f72d6de6de395d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.9/erwindb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "821fa69cefeb7443ea3be7f9bf454620e066ac5e0585080ad163e4262aa2779c"
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
    bin.install "erwindb" if OS.mac? && Hardware::CPU.arm?
    bin.install "erwindb" if OS.linux? && Hardware::CPU.arm?
    bin.install "erwindb" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
