require 'rbconfig'

##
# Returns an array [x,y] containing the mouse coordinates
# Be aware that the coordinate system is OS dependent.
def getMouseLocation
  def windows
    require "Win32API"
    getCursorPos = Win32API.new("user32", "GetCursorPos", 'P', 'L')
    # point is a Long,Long-struct
    point = "\0" * 8
    if getCursorPos(point)
      a.unpack('LL')
    else
      [nil,nil]
    end
  end

  def linux
    loc_string = `xdotool getmouselocation --shell`[/X=(\d+)\nY=(\d+)/]
    loc_string.lines.map {|s| s[/.=(\d+)/, 1].to_i}
  end

  def osx
    # if we are running in RubyCocoa, we can access objective-c libraries
    require "osx/cocoa"
    OSX::NSEvent.mouseLocation.to_a
  rescue LoadError
    # we are not running in ruby cocoa, but it should be preinstalled on every system
    coords = `/usr/bin/ruby -e 'require "osx/cocoa"; puts OSX::NSEvent.mouseLocation.to_a'`
    coords.lines.map {|s| s.to_f }
  end

  case RbConfig::CONFIG['host_os']
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    windows
  when /darwin|mac os/
    osx
  when /linux|solaris|bsd/
    linux
  else
    raise Error, "unknown os: #{host_os.inspect}"
  end
rescue Exception => e
  [nil,nil]
end
