require 'rubygems'
require 'hotcocoa/graphics'
include HotCocoa
include Graphics

# Find the number of circles to draw
circles = rand(150)
while circles < 25
  circles = rand(150)
end

# Find the next filename to use without delete or overwriting any images
fileManager = NSFileManager.new
file = fileManager.currentDirectoryPath.stringByAppendingPathComponent('circles.png')

i = 0
while fileManager.fileExistsAtPath(file)
  file = fileManager.currentDirectoryPath
  file = file.stringByAppendingPathComponent('circles-' + i.to_s + '.png')
  i += 1
end

# Make our canvas, 8.5"x11" at 300dpi
canvas = Canvas.new(:type => :image, :filename => file, :size => [2550,3300])
canvas.background(Image.new('greys.jpg').colors(1).first)

# Find an initial color to start working with
color = Color.random

# Create circles to display
for i in 0...circles
  radius = rand((canvas.width / 9)) # Limit the size of the circle
  x = rand(canvas.width)
  y = rand(canvas.height)

  circle = Path.new.oval(x, y, radius, radius, :center)
  circle.fill(color)

  canvas.draw(circle)

  # Find a new color for the next cycle
  if (((rand * 100) % 2) > 1)
    color = color.drift
  else
    color = color.complement
  end
end

canvas.save