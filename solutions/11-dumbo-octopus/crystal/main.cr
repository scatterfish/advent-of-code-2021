grid = File.read_lines("input.txt").map(&.chars.map(&.to_i))

def get_neighbors(grid, x, y)
	deltas = [-1, 0, 1].repeated_permutations(2).reject(&.all?(0))
	return deltas.map {|(d_x, d_y)| {x + d_x, y + d_y}}.select { |n_x, n_y|
		n_x >= 0 && n_x < grid[y].size &&
		n_y >= 0 && n_y < grid.size
	}
end

def flash_flood(grid, x, y, flashed)
	return if flashed.includes?({x, y})
	flashed << {x, y}
	neighbors = get_neighbors(grid, x, y)
	neighbors.each do |n_x, n_y|
		grid[n_y][n_x] += 1
		flash_flood(grid, n_x, n_y, flashed) if grid[n_y][n_x] > 9
	end
end

flash_count = 0

1.step do |i|
	
	flashed = Array(Tuple(Int32, Int32)).new
	(0...grid.size).each do |y|
		(0...grid[y].size).each do |x|
			grid[y][x] += 1
			flash_flood(grid, x, y, flashed) if grid[y][x] > 9
		end
	end
	
	flashed.each do |x, y|
		flash_count += 1
		grid[y][x] = 0
	end
	
	if i == 100
		puts "Part 1 answer: #{flash_count}"
	elsif flashed.size == 100
		puts "Part 2 answer: #{i}"
		break
	end
	
end
