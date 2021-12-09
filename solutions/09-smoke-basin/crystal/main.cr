grid = File.read_lines("input.txt").map(&.chars.map(&.to_i))

risk_sum = 0
low_points = Array(Tuple(Int32, Int32)).new

def get_neighbors(grid, x, y)
	neighbors = Array(Tuple(Int32, Int32)).new
	neighbors << {x + 1, y} if x < grid[y].size - 1
	neighbors << {x - 1, y} if x > 0
	neighbors << {x, y + 1} if y < grid.size - 1
	neighbors << {x, y - 1} if y > 0
	return neighbors
end

(0...grid.size).each do |y|
	(0...grid[y].size).each do |x|
		neighbors = get_neighbors(grid, x, y)
		if neighbors.all? {|n_x, n_y| grid[n_y][n_x] > grid[y][x]}
			risk_sum += grid[y][x] + 1
			low_points << {x, y}
		end
	end
end

puts "Part 1 answer: #{risk_sum}"

def get_basin(grid, x, y, basin=Array(Tuple(Int32, Int32)).new)
	return basin if grid[y][x] == 9 || basin.includes?({x, y})
	basin << {x, y}
	neighbors = get_neighbors(grid, x, y)
	neighbors.each do |n_x, n_y|
		get_basin(grid, n_x, n_y, basin)
	end
	return basin
end

top_basins = low_points.map {|x, y| get_basin(grid, x, y).size}.sort.last(3)
puts "Part 2 answer: #{top_basins.product}"
