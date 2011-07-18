# capture_ffox.rb
require 'java'

# Patterned off of this:
# http://www.rgagnon.com/javadetails/java-0489.html
# This is a JRuby script.

tk = java.awt.Toolkit.getDefaultToolkit().getScreenSize()
rect = java.awt.Rectangle.new(tk)
screencapture = java.awt.Robot.new().createScreenCapture(rect)
my_file = java.io.File.new("/tmp/screencapture.png")
javax.imageio.ImageIO.write(screencapture, "png", my_file)
