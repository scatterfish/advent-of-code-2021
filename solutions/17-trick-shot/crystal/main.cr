targets = File.read("input.txt").scan(/(-?[0-9]+)\.\.(-?[0-9]+)/).map(&.captures)
x_range, y_range = targets.map(&.map(&.not_nil!.to_i)).map {|(min, max)| (min..max)}

# Not a fan of this problem
def test_shot(x_vel, y_vel, x_range, y_range)
	x_pos = 0
	y_pos = 0
	loop do
		x_pos += x_vel
		y_pos += y_vel
		x_vel -= x_vel > 0 ? 1 : -1 unless x_vel == 0
		y_vel -= 1
		return true if x_range.includes?(x_pos) && y_range.includes?(y_pos)
		return false if y_pos < y_range.min
	end
end

valid_count = (y_range.min..y_range.min.abs).sum { |y_vel_i|
	(1..x_range.max).count { |x_vel_i|
		test_shot(x_vel_i, y_vel_i, x_range, y_range)
	}
}

puts "Part 1 answer: #{(1..(y_range.min.abs - 1)).sum}"
puts "Part 2 answer: #{valid_count}"
