class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.10"
  license "GPL-3.0-or-later"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "da7d4a99ad581f92526c5d16ef8c1f1fbb00fb64e6b31886750735d67365e594"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync", "epubsync-app"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
