class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  version "0.9.11"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.11/erwindb-aarch64-apple-darwin.tar.xz"
      sha256 "3232451fe70b6c25fc473490485529a2a774446b5e0c4eadeb83f1d1ef4e8d83"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.11/erwindb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fdf8dc5c7331a8a5efcc8d1e52b5b8b188b7279001387a39c9660a20a5c5a51a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.11/erwindb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "583f37750f58825fccdc84e8de3b056e7899dd432873c84670adf97ce17a3dd9"
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
