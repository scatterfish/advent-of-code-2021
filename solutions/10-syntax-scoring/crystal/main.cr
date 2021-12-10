lines = File.read_lines("input.txt").map(&.chars)

VALID_MAP = {
	'(' => ')',
	'[' => ']',
	'{' => '}',
	'<' => '>',
}

SCORE_MAP = {
	')' => 3,
	']' => 57,
	'}' => 1197,
	'>' => 25137,
	
	'(' => 1,
	'[' => 2,
	'{' => 3,
	'<' => 4,
}

error_score = 0
closing_scores = Array(UInt64).new

lines.each do |line|
	
	stack = Array(Char).new
	valid = true
	line.each do |char|
		if VALID_MAP[char]?
			stack << char
		else
			if VALID_MAP[stack.pop] != char
				error_score += SCORE_MAP[char]
				valid = false
			end
		end
	end
	
	closing_scores << stack.reverse.reduce(0_u64) { |score, char|
		score * 5 + SCORE_MAP[char]
	} if valid
	
end

puts "Part 1 answer: #{error_score}"
puts "Part 2 answer: #{closing_scores.sort[closing_scores.size // 2]}"
