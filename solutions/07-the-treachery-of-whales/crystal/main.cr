crabs = File.read("input.txt").strip.split(",").map(&.to_i)

costs_1, costs_2 = (crabs.min..crabs.max).map { |pos|
	crabs.map { |crab|
		[(crab - pos).abs, (1..(crab - pos).abs).sum]
	}.transpose.map(&.sum)
}.transpose

puts "Part 1 answer: #{costs_1.min}"
puts "Part 2 answer: #{costs_2.min}"
