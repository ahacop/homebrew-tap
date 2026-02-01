class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  version "0.9.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.2/erwindb-aarch64-apple-darwin.tar.xz"
      sha256 "5e13a08dab6b7856d6c031d462c96f4cfd2041c0e775ac6d2f570323e1f4114f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.2/erwindb-x86_64-apple-darwin.tar.xz"
      sha256 "0f97a671f63bd92254ad71413eb45fdb178d4a88846a6c706a55984ce5dec0b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.2/erwindb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d04b2b77058ae9433cbd3414b2c896c8e716dcc8c070607ecb4a24582802c2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.2/erwindb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1cbfbcc5c20576a27c612354ad1327a62178486466efb694d55de494b369be8"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "erwindb" if OS.mac? && Hardware::CPU.intel?
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
