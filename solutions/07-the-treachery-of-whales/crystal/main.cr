crabs = File.read("input.txt").strip.split(",").map(&.to_i).sort

puts "Part 1 answer: #{crabs.sum {|crab| (crab - crabs[crabs.size // 2]).abs}}"
puts "Part 2 answer: #{crabs.sum {|crab| (1..(crab - crabs.sum // crabs.size).abs).sum}}"
