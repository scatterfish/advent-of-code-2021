rules = File.read_lines("input.txt").reject(&.empty?).map(&.split(" -> "))
polymer = rules.shift.shift.chars
rules_map = rules.to_h

def polymer_minmax_difference(polymer, rules_map, step_count)
	pairs = polymer.each_cons(2).to_a.map(&.join)
	pair_counts = pairs.to_h {|pair| {pair, pairs.count(pair)}}
	
	step_count.times do
		new_pair_counts = Hash(String, Int128).new(0_i128)
		pair_counts.each do |pair, count|
			element = rules_map[pair]
			new_pairs = [pair[0] + element, element + pair[1]]
			new_pairs.each do |new_pair|
				new_pair_counts[new_pair] += pair_counts[pair]
			end
		end
		pair_counts = new_pair_counts
	end
	
	elements = rules_map.values.uniq
	least, most = elements.minmax_of { |char|
		elements.sum {|other| pair_counts[other + char]}
	}
	return most - least
end

puts "Part 1 answer: #{polymer_minmax_difference(polymer, rules_map, 10)}"
puts "Part 2 answer: #{polymer_minmax_difference(polymer, rules_map, 40)}"
