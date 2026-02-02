class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  version "0.9.10"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.10/erwindb-aarch64-apple-darwin.tar.xz"
      sha256 "2c0f7a0226fd2dbc7b0ab74a74f329d77f007786b55a0652c1d3905d96fe04c6"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.10/erwindb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ea9958c54d5c29a58655e1983c4813417f4211191d18ff574ba867e87c8269f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.10/erwindb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "808377f8a03e913cd259386c98a8cfc56bce8dfa067ec50b431b41ab7118b91b"
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
