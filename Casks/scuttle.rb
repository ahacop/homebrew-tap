cask "scuttle" do
  version "0.7"
  sha256 "b9511ef3750491e7ef168418a94d5575bacbb3626f534d826cd7f095617332ba"

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
