commands = File.read_lines("input.txt").map(&.split).map {|(dir, val)| {dir, val.to_i}}

forward = 0
depth_1 = 0
depth_2 = 0
aim = 0

commands.each do |dir, val|
	
	case dir
	when "down"
		depth_1 += val
		aim += val
	when "up"
		depth_1 -= val
		aim -= val
	when "forward"
		forward += val
		depth_2 += val * aim
	end
	
end

puts "Part 1 answer: #{forward * depth_1}"
puts "Part 2 answer: #{forward * depth_2}"
