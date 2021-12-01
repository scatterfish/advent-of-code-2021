depths = File.read_lines("input.txt").map(&.to_i)

def count(list)
	list.to_a.each_cons(2).count {|(a, b)| b > a}
end

puts "Part 1 answer: #{count(depths)}"
puts "Part 2 answer: #{count(depths.each_cons(3).map(&.sum))}"
