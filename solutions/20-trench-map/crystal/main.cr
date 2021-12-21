image = File.read_lines("input.txt").reject(&.empty?).map(&.chars)
algo = image.shift.map {|c| c == '#'}

pixels = Hash(Tuple(Int32, Int32), Bool).new
(0...image.size).each do |y|
	(0...image[y].size).each do |x|
		pixels[{x, y}] = image[y][x] == '#'
	end
end

def algo_index(adjacent) # Performance
	index = 0
	adjacent.each_with_index do |bit, i|
		index |= bit << (8 - i)
	end
	return index
end

def enhance(pixels, algo, cycles)
	1.upto(cycles) do |cycle|
		pixels_next = Hash(Tuple(Int32, Int32), Bool).new
		
		x_min, y_min = pixels.keys.transpose.map(&.min)
		x_max, y_max = pixels.keys.transpose.map(&.max)
		
		border_value = algo.first ? cycle % 2 == 0 : false
		((y_min - 1)..(y_max + 1)).each do |y|
			((x_min - 1)..(x_max + 1)).each do |x|
				adjacent = (0...9).map { |i| # Performance
					d_x = i % 3 - 1
					d_y = i // 3 - 1
					pixels.fetch({x + d_x, y + d_y}, border_value) ? 1 : 0
				}
				pixels_next[{x, y}] = algo[algo_index(adjacent)]
			end
		end
		
		pixels = pixels_next
	end
	return pixels.count {|_, lit| lit}
end

enhanced = enhance(pixels.clone, algo, 2)
puts "Part 1 answer: #{enhanced}"

ultra_enhanced = enhance(pixels.clone, algo, 50)
puts "Part 2 answer: #{ultra_enhanced}"
