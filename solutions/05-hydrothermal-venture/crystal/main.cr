lines = File.read_lines("input.txt").map(&.split("->").map(&.split(",").map(&.to_i)))

x_max, y_max = lines.map(&.transpose.max).max

grid = Array.new(y_max + 1) { Array.new(x_max + 1, 0) }

def count_intersections(grid, lines, diagonals=false)
	lines.map(&.flatten).each do |(x1, y1, x2, y2)|
		next if x1 != x2 && y1 != y2 && !diagonals
		d_x = x1 == x2 ? 0 : x1 < x2 ? 1 : -1
		d_y = y1 == y2 ? 0 : y1 < y2 ? 1 : -1
		(0..{(x2 - x1).abs, (y2 - y1).abs}.max).each do |i|
			x = x1 + d_x * i
			y = y1 + d_y * i
			grid[y][x] += 1
		end
	end
	return grid.sum(&.count {|cell| cell >= 2})
end

puts "Part 1 answer: #{count_intersections(grid.clone, lines)}"
puts "Part 2 answer: #{count_intersections(grid.clone, lines, diagonals=true)}"
