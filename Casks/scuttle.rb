cask "scuttle" do
  version "0.4"
  sha256 "a0c9a0138b66bb31f2216c3adb8716104d34d038b92a95654adbb35776eacec5"

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
