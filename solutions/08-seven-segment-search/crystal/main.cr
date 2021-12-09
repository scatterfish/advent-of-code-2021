data = File.read_lines("input.txt").map(&.split("|").map(&.split.map(&.chars.sort)))

easy_digits = data.sum {|(_, outputs)| outputs.count { |code|
	[2, 3, 4, 7].includes?(code.size)
}}
puts "Part 1 answer: #{easy_digits}"

SUM_MAP = {
	42 => 0,
	17 => 1,
	34 => 2,
	39 => 3,
	30 => 4,
	37 => 5,
	41 => 6,
	25 => 7,
	49 => 8,
	45 => 9,
}

def decode(patterns, outputs)
	counts = "abcdefg".chars.to_h {|c| {c, patterns.count {|code| code.includes?(c)}}}
	return outputs.map {|code| SUM_MAP[code.sum {|c| counts[c]}]}.join.to_i
end

output_sum = data.sum {|(patterns, outputs)| decode(patterns, outputs)}
puts "Part 2 answer: #{output_sum}"
