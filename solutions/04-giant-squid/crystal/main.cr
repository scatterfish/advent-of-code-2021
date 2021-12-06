numbers = File.read("input.txt").split("\n\n").map(&.strip.split(/[,\s]+/).map(&.to_i))
called = numbers.shift
boards = numbers.map {|grid_numbers| Board.new(grid_numbers)}

class Board
	
	@grid : Array(Array(Int32))
	
	def initialize(grid_numbers : Array(Int32))
		@grid = grid_numbers.in_groups_of(5, 0)
		@called = Array(Int32).new
	end
	
	def add_called(number)
		@called << number
	end
	
	def won?
		return {@grid, @grid.transpose}.any? { |grid|
			grid.any? { |row|
				row.all? {|number| @called.includes?(number)}
			}
		}
	end
	
	def score
		uncalled_sum = @grid.flatten.reject {|number| @called.includes?(number)}.sum
		return uncalled_sum * @called.last
	end
	
end

won_boards = Array(Board).new

until boards.all?(&.won?)
	number = called.shift
	boards.dup.each do |board|
		board.add_called(number)
		if board.won?
			won_boards << board
			boards.delete(board)
		end
	end
end

puts "Part 1 answer: #{won_boards.first.score}"
puts "Part 2 answer: #{won_boards.last.score}"
