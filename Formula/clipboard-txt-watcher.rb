class ClipboardTxtWatcher < Formula
  desc "Watch a text file and sync its contents to the system clipboard"
  homepage "https://github.com/ahacop/clipboard-txt-watcher"
  url "https://github.com/ahacop/clipboard-txt-watcher/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "226f7a7d57598babb0aae4ef0fb519ef22d19b55861eea2e91e4bbdeb841d149"
  license "GPL-3.0-or-later"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "-o", bin/"clipboard-txt-watcher", "."
  end

  service do
    run [opt_bin/"clipboard-txt-watcher", "--file", "#{Dir.home}/clipboard.txt", "--backend", "darwin"]
    keep_alive true
    working_dir Dir.home
    log_path var/"log/clipboard-txt-watcher.log"
    error_log_path var/"log/clipboard-txt-watcher.log"
  end

  def caveats
    <<~EOS
      The service watches ~/clipboard.txt by default.

      To start the service:
        brew services start clipboard-txt-watcher

      To stop the service:
        brew services stop clipboard-txt-watcher

      To check service status:
        brew services info clipboard-txt-watcher

      To view logs:
        tail -f #{var}/log/clipboard-txt-watcher.log

      To use a custom config file instead, create:
        ~/.config/clipboard-txt-watcher/config.toml

      Example config:
        watch_file = "/path/to/your/file.txt"
        clipboard_backend = "darwin"

      Then run manually:
        clipboard-txt-watcher --config ~/.config/clipboard-txt-watcher/config.toml
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clipboard-txt-watcher --version")
  end
end
