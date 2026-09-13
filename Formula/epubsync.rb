class Epubsync < Formula
  desc "Manage a KEPUB library and sync it to a Kobo"
  homepage "https://github.com/ahacop/epub-sync"
  url "https://github.com/ahacop/epub-sync/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "5151882577d5e17f8ba52a9af7f18714ae8c5a268a387ab820356279325439b2"
  license "MIT"
  head "https://github.com/ahacop/epub-sync.git", branch: "main"

  # Both are build-time only. build.rs compiles the kepubify shim with Go
  # from the vendored modules and links it into the Rust binary.
  depends_on "go" => :build
  depends_on "rust" => :build

  def install
    ENV["GOFLAGS"] = "-mod=vendor"
    ENV["GOPROXY"] = "off"
    ENV["GOCACHE"] = buildpath/"go-cache"
    ENV["CGO_ENABLED"] = "1"
    system "cargo", "install", *std_cargo_args(path: "crates/epubsync-cli")
  end

  test do
    assert_match "epubsync #{version}", shell_output("#{bin}/epubsync --version")
    ENV["EPUBSYNC_CONFIG"] = testpath/"config.toml"
    system bin/"epubsync", "init", testpath/"library"
    assert_path_exists testpath/"library/library.sqlite"
  end
end
