require "priority-queue" # `shards install`

grid = File.read_lines("input.txt").map(&.chars.map(&.to_i))

def get_neighbors(grid, x, y)
	neighbors = Array(Tuple(Int32, Int32)).new
	neighbors << {x + 1, y} if x < grid[y].size - 1
	neighbors << {x - 1, y} if x > 0
	neighbors << {x, y + 1} if y < grid.size - 1
	neighbors << {x, y - 1} if y > 0
	return neighbors
end

def dijkstra(grid, start={0, 0})
	target = {grid[0].size - 1, grid.size - 1}
	seen = Set(Tuple(Int32, Int32)).new
	queue = Priority::Queue(Tuple(Int32, Int32)).new
	queue.push(0, start)
	until queue.empty?
		item = queue.shift
		risk = item.priority
		coords = item.value
		next if seen.includes?(coords)
		return risk if coords == target
		seen << coords
		neighbors = get_neighbors(grid, *coords)
		neighbors.each do |n_x, n_y|
			queue.push(risk + grid[n_y][n_x], {n_x, n_y})
		end
	end
end

puts "Part 1 answer: #{dijkstra(grid)}"

big_grid = (0...5).flat_map { |g_y|
	grid.map { |row|
		(0...5).flat_map { |g_x|
			row.map { |risk|
				big_risk = risk + g_x + g_y
				big_risk > 9 ? big_risk - 9 : big_risk
			}
		}
	}
}

puts "Part 2 answer: #{dijkstra(big_grid)}"
