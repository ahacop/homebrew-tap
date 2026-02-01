class Erwindb < Formula
  desc "TUI for browsing Erwin Brandstetter's Stack Overflow Q&A"
  homepage "https://github.com/ahacop/erwindb"
  url "https://github.com/ahacop/erwindb/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "3649947818aadb765e5e24ec1f86e4f15e8e677944138b5896e785d943b09cb7"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_predicate bin/"erwindb", :executable?
  end
end
