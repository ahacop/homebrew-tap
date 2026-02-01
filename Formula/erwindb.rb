class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  version "0.9.7"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.7/erwindb-aarch64-apple-darwin.tar.xz"
      sha256 "ce01cbf63a62648301e16a7db138e814bd3691d79499c1647b31d1db4eadc1f5"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.7/erwindb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0277cf8e68f6853609fe6c08b955b1c51d0f0e0d558d5a3adf278792fba0b19f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ahacop/erwindb/releases/download/v0.9.7/erwindb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fb512a79b6fb1393443bf4871970d6768fade1d2f9e1cb1881975ab1451deea2"
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
