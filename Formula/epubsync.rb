class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.11"
  license "GPL-3.0-or-later"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "9c252c699459059b7597385e4161c61d8b7bfce105d14018846e42570490db03"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync", "epubsync-app"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
