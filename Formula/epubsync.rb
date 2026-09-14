class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.5"
  license "GPL-3.0-or-later"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "363ab6b763513c4aee2ae4f618fc8587c37bd70874865e1e101c8157b344471c"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
