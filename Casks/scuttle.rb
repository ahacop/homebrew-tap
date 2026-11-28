cask "scuttle" do
  version "0.9"
  sha256 "79ca1faa6793594261a6f890cc1e586336f7f7a23346ba85ec2cf47bdd268993"

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
