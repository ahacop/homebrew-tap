cask "scuttle" do
  version "0.8"
  sha256 "0e6ea558391ea02dc57c05bd1b8fa074733bbf694e1f9d41aaf3fe1aeea42c3f"

  url "https://github.com/ahacop/scuttle/releases/download/v#{version}/scuttle.app.zip"
  name "scuttle"
  desc "Tiling window manager for macOS on native Spaces, with SIP left on"
  homepage "https://ahacop.github.io/scuttle/"

  livecheck do
    url "https://github.com/ahacop/scuttle/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "scuttle.app"
  binary "#{appdir}/scuttle.app/Contents/MacOS/scuttle"

  zap trash: [
    "~/Library/Application Support/scuttle",
    "~/Library/Preferences/com.ahacop.scuttle.plist",
  ]
end
