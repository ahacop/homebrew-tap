class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.7"
  license "GPL-3.0-or-later"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "aa987900317fafe15ea11b524ad1cb93a0a61e58f5d35737538090cc45468e51"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync", "epubsync-app"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
