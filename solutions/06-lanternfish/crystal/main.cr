fish = File.read("input.txt").strip.split(",").map(&.to_i)

def simulate(fish, day_count)
	days = Array.new(9, 0_u64)
	fish.each do |timer_val|
		days[timer_val] += 1
	end
	day_count.times do
		days.rotate!
		days[6] += days.last
	end
	return days.sum
end

puts "Part 1 answer: #{simulate(fish, 80)}"
puts "Part 2 answer: #{simulate(fish, 256)}"
