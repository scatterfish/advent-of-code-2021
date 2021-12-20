numbers = File.read_lines("input.txt").map { |line|
	number = Array(SnailfishNumber).new
	depth = 0
	line.each_char do |char|
		depth += 1 if char == '['
		depth -= 1 if char == ']'
		number << SnailfishNumber.new(char.to_i, depth) if char.ascii_number?
	end
	number
}

class SnailfishNumber
	property value : Int32
	property depth : Int32
	def initialize(@value, @depth)
	end
	def inc_depth
		SnailfishNumber.new(@value, @depth + 1)
	end
end

def add_numbers(base_number, new_number)
	combined = (base_number + new_number).map(&.inc_depth)
	loop do
		explode_index = combined.index {|num| num.depth > 4}
		if explode_index
			explode_number(combined, explode_index)
			next
		end
		split_index = combined.index {|num| num.value > 9}
		if split_index
			split_number(combined, split_index)
			next
		end
		break
	end
	return combined
end

def explode_number(number, index)
	left, right = number[index, 2]
	number[index - 1].value += left.value if index > 0
	number[index + 2].value += right.value if number[index + 2]?
	left.value = 0
	left.depth -= 1
	number.delete(right)
end

def split_number(number, index)
	num = number[index].inc_depth
	number[index..index] = [
		SnailfishNumber.new(num.value // 2,                 num.depth),
		SnailfishNumber.new(num.value // 2 + num.value % 2, num.depth),
	]
end

def magnitude(number)
	until (max_depth = number.max_of(&.depth)) == 0
		target_index = number.index {|num| num.depth == max_depth}.not_nil!
		left, right = number[target_index, 2]
		left.value = 3 * left.value + 2 * right.value
		left.depth -= 1
		number.delete(right)
	end
	return number.first.value
end

sum_magnitude = magnitude(numbers.reduce{|a, b| add_numbers(a, b)})
puts "Part 1 answer: #{sum_magnitude}"

pair_sums = numbers.permutations(2).map {|(a, b)| add_numbers(a, b)}
max_pair_magnitude = pair_sums.max_of {|num| magnitude(num)}
puts "Part 2 answer: #{max_pair_magnitude}"
