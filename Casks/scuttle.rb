cask "scuttle" do
  version "0.1"
  sha256 "5e487016e39ce9a28123dd1f80d8ef5e3e2b98b1dcc17bcf2ee91cbcff771015"

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
