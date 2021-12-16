hex = File.read("input.txt").strip.chars
bits = hex.join(&.to_i(16).to_s(2).rjust(4, '0')).chars

struct Packet
	property version  = 0_u128
	property type     = 0_u128
	property value    = 0_u128
	property children = Array(Packet).new
end

macro int_value(bits)
	{{bits}}.join.to_u128(2)
end

# We meet again, 2018 Day 8
def get_packet_tree(bits)
	packet = Packet.new
	packet.version = int_value(bits.shift(3))
	packet.type    = int_value(bits.shift(3))
	
	if packet.type == 4
		value_bits = Array(Char).new
		loop do
			continue = bits.shift
			value_bits += bits.shift(4)
			break if continue == '0'
		end
		packet.value = int_value(value_bits)
	else
		if bits.shift == '0'
			child_length = int_value(bits.shift(15))
			child_bits = bits.shift(child_length)
			until child_bits.empty?
				packet.children << get_packet_tree(child_bits)
			end
		else
			child_count = int_value(bits.shift(11))
			until packet.children.size == child_count
				packet.children << get_packet_tree(bits)
			end
		end
	end
	
	return packet
end

def get_version_sum(packet)
	child_sum = packet.children.sum(0) { |child_packet|
		get_version_sum(child_packet)
	}
	return packet.version + child_sum
end

def get_value(packet)
	return packet.value if packet.type == 4
	
	child_values = packet.children.map { |child_packet|
		get_value(child_packet)
	}
	child_comp = child_values.first <=> child_values.last
	
	case packet.type
	when 0
		return child_values.sum
	when 1
		return child_values.product
	when 2
		return child_values.min
	when 3
		return child_values.max
	when 5
		return child_comp ==  1 ? 1_u128 : 0_u128
	when 6
		return child_comp == -1 ? 1_u128 : 0_u128
	when 7
		return child_comp ==  0 ? 1_u128 : 0_u128
	end
	return 0_u128
end

root = get_packet_tree(bits)

puts "Part 1 answer: #{get_version_sum(root)}"
puts "Part 2 answer: #{get_value(root)}"
