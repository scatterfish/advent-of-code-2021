data = File.read_lines("input.txt").map(&.split("|").map(&.split.map(&.chars.sort)))

easy_digit_count = data.sum {|(_, outputs)| outputs.count { |code|
	[2, 3, 4, 7].includes?(code.size)
}}
puts "Part 1 answer: #{easy_digit_count}"

def eliminate(codes, &block : Array(Char) -> Bool)
	code = codes.find(&block)
	return codes.delete(code).not_nil!
end

def decode(patterns, outputs)
	
	size_map = Hash(Int32, Array(Array(Char))).new { |hash, key|
		hash[key] = Array(Array(Char)).new
	}
	patterns.each do |code|
		size_map[code.size] << code
	end
	
	decoded = Hash(Int32, Array(Char)).new
	
	decoded[1] = size_map[2].first
	decoded[4] = size_map[4].first
	decoded[7] = size_map[3].first
	decoded[8] = size_map[7].first
	decoded[3] = eliminate(size_map[5]) {|code| (decoded[1] - code).none?}
	decoded[9] = eliminate(size_map[6]) {|code| (decoded[4] - code).none?}
	decoded[5] = eliminate(size_map[5]) {|code| (decoded[9] - code).one? }
	decoded[6] = eliminate(size_map[6]) {|code| (decoded[5] - code).none?}
	decoded[2] = size_map[5].first
	decoded[0] = size_map[6].first
	
	return outputs.map {|code| decoded.key_for(code)}.join.to_i
	
end

output_sum = data.sum {|(patterns, outputs)| decode(patterns, outputs)}
puts "Part 2 answer: #{output_sum}"
