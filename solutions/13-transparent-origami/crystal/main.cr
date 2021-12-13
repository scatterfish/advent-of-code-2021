dots, folds = File.read("input.txt").split("\n\n").map(&.split)
dots = dots.map {|coords| coords.split(",").map(&.to_i)}.map {|(x, y)| Point.new(x, y)}
folds = (folds - ["fold", "along"]).map(&.split("="))

class Point
	property x : Int32
	property y : Int32
	def initialize(@x, @y)
	end
end

first_fold = true
folds.each do |(axis, pos)|
	pos = pos.to_i
	
	dots.each do |dot|
		if axis == "x" && dot.x > pos
			dot.x -= (dot.x - pos) * 2
		elsif axis == "y" && dot.y > pos
			dot.y -= (dot.y - pos) * 2
		end
	end
	
	if first_fold
		puts "Part 1 answer: #{dots.uniq {|dot| {dot.x, dot.y}}.size}"
		first_fold = false
	end
end

x_min, x_max = dots.minmax_of(&.x)
x_size = x_max - x_min + 1
y_min, y_max = dots.minmax_of(&.y)
y_size = y_max - y_min + 1

grid = Array(Array(Char)).new(y_size) { Array(Char).new(x_size, ' ') }
dots.each do |dot|
	grid[dot.y][dot.x] = '\u2588'
end

puts "Part 2 answer:"
puts grid.map(&.join).join("\n")
