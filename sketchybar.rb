class Sketchybar < Formula
  desc "A custom macOS statusbar with shell plugin, interaction and graph support"
  homepage "https://github.com/FelixKratz/SketchyBar"
  url "https://github.com/FelixKratz/SketchyBar/archive/refs/tags/v1.0.tar.gz"
  sha256 "7786c88fccef4f75ecdf1b5d2f1fb7ca0516c1f9e7e2c019f6133016e73c5ee0"
  head "https://github.com/FelixKratz/SketchyBar.git"

  def install
    (var/"log/sketchybar").mkpath
    system "make"
    bin.install "#{buildpath}/bin/sketchybar"
    if (!Dir.exist?('~/.config/sketchybar/'))
      system "mkdir ~/.config/sketchybar/"
      system "cp #{buildpath}/sketchybarrc ~/.config/sketchybar/"
      system "cp -r #{buildpath}/plugins ~/.config/sketchybar/"
      system "chmod +x ~/.config/sketchybar/plugins/*"
    end
  end

  plist_options :manual => "sketchybar"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/sketchybar</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
        <key>PATH</key>
        <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
      </dict>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>#{var}/log/sketchybar/sketchybar.out.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/sketchybar/sketchybar.err.log</string>
      <key>ProcessType</key>
      <string>Interactive</string>
      <key>Nice</key>
      <integer>-20</integer>
    </dict>
    </plist>
    EOS
  end
end
