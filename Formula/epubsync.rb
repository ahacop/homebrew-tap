class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  version "0.1.4"
  license "MIT"

  url "https://github.com/ahacop/epub-sync/releases/download/v#{version}/epubsync-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "epubsync"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/epubsync --version")
  end
end
