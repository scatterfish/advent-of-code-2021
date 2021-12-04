words = File.read_lines("input.txt").map(&.chars.map(&.to_i))
WORD_SIZE = words.first.size

def bit_index_max(words, i, invert=false)
	ones, zeros = words.partition {|word| word[i] == 1}.map(&.size)
	return (ones >= zeros) ^ invert ? 1 : 0
end

def eliminate_least(words, invert=false)
	map_bits do |i|
		target = bit_index_max(words, i, invert)
		words.select! {|word| word[i] == target}
		return words.first if words.one?
	end
end

macro int_value(word)
	{{word}}.join.to_i(2)
end

macro map_bits(&block)
	(0...{{WORD_SIZE}}).map {{block}}
end

gamma   = map_bits {|i| bit_index_max(words, i)}
epsilon = map_bits {|i| bit_index_max(words, i, invert=true)}

puts "Part 1 answer: #{int_value(gamma) * int_value(epsilon)}"

o2_rating  = eliminate_least(words.clone)
co2_rating = eliminate_least(words.clone, invert=true)

puts "Part 2 answer: #{int_value(o2_rating) * int_value(co2_rating)}"
