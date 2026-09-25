class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.9"
  license "GPL-3.0-or-later"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "a704761fc52f2530138a36961132894e8071803bbb9000cc265f505bac90478f"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync", "epubsync-app"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
