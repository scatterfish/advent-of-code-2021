segments = File.read_lines("input.txt").map(&.split("-"))

cave_map = Hash(String, Array(String)).new {|hash, key| hash[key] = Array(String).new}
segments.each do |(a, b)|
	cave_map[a] << b
	cave_map[b] << a
end

def get_path_count(cave_map, backtrack=false, src="start", known=Set(String).new)
	known << src
	return src == "end" ? 1 : cave_map[src].sum { |dst|
		if dst.matches?(/[a-z]/) && known.includes?(dst)
			if backtrack && dst != "start"
				get_path_count(cave_map, false, dst, known.dup)
			else
				0
			end
		else
			get_path_count(cave_map, backtrack, dst, known.dup)
		end
	}
end

puts "Part 1 answer: #{get_path_count(cave_map)}"
puts "Part 2 answer: #{get_path_count(cave_map, backtrack=true)}"
