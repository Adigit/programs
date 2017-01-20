#Find zeroes to be flipped so that number of consecutive 1’s is maximized
class LongestChain
	attr_accessor :arr, :number_of_zeros_can_be_flipped
	def initialize(arr, number_of_zeros_can_be_flipped)
		@arr = arr
		@number_of_zeros_can_be_flipped = number_of_zeros_can_be_flipped
	end

	def longest_chain_length
		start_index = 0
		end_index = 0
		i = 0
		k = 1
		max_length = 0
		while ((end_index < @arr.size) && (start_index <= end_index))
			p ">> start >> start_index >> #{start_index} >> end_index >> #{end_index} >> "
			length = 0
			if start_index == 0
				while ((k < @number_of_zeros_can_be_flipped) && (i < @arr.size))
					k += 1 if @arr[i] == 0
					i += 1
				end
				return (@arr.size - 1) if i == @arr.size
				while (@arr[i] == 1)
					i += 1
				end
				end_index = i
			else
				if @arr[start_index] == 0
					start_index += 1
				else
					while (@arr[start_index] == 1)
						start_index += 1
					end
				end
				if @arr[end_index] != 0
					zeros_count = 0
					while end_index < @arr.size
						zeros_count += 1 if @arr[end_index] == 0
						break if zeros_count > 1
						end_index += 1
					end
				end
				end_index -= 1
			end
			if start_index < end_index
				length = end_index - start_index + 1
				max_length = length if length > max_length
			end
			p ">> end >> start_index >> #{start_index} >> end_index >> #{end_index} >> "
			start_index += 1
			end_index += 1
		end
		max_length
	end
end
arr = [0,0,0,0,0,0,0,0,1]
arr = [1,0,0,1,1,0,1,0,1,1]
p LongestChain.new(arr, 2).longest_chain_length
#class FindZeros
	# attr_accessor :arr, :number_of_zeros, :left, :right
	# def initialize(arr, number_of_zeros)
	# 	@arr = arr
	# 	@left = Array.new(@arr.size) 
	# 	@right = Array.new(@arr.size) 
	# 	@number_of_zeros = number_of_zeros
	# end

	# def find_position_on_zeros
	# 	number_of_zeros = @number_of_zeros.dup
	# 	prepare_left_n_right_arrays
	# 	start_window = 0
	# 	end_window = 0
	# 	i = 0
		
	# 	while i < @arr.size && number_of_zeros > 0 
	# 		number_of_zeros -= 1 (if @arr[i] == 0)
	# 		i += 1
	# 	end
	# 	end_window = i
		
	# 	#Case number_of_zeros which can be switched are more than number of zeros present in array
	# 	if end_window >= @arr.size-1
	# 		@arr.each_with_index {|x, index| p index (if x == 0) }
	# 	end

	# 	max_length = 0
	# 	@arr[start_window..end_window].each_with_index do |index, a|
	# 		if a == 0
	# 			max_length += @left[index] + @right[index] + 1
	# 		end
	# 	end

	# 	while end_window < @arr.size 
	# 		@arr.each do |a|

	# 		end
	# 	end

	# end

	# def prepare_left_n_right_arrays
	# 	number_of_consecutive_ones = 0
	# 	@arr.each_with_index do |index, a|
	# 		if a == 0
	# 			@left[index] = number_of_consecutive_ones
	# 			number_of_consecutive_ones = 0
	# 		else
	# 			number_of_consecutive_ones += 1
	# 		end
	# 	end
	# 	number_of_consecutive_ones = 0
	# 	@arr[(@arr.size-1)..0].each_with_index do |index, a|
	# 		if a == 0
	# 			@right[index] = number_of_consecutive_ones
	# 			number_of_consecutive_ones = 0
	# 		else
	# 			number_of_consecutive_ones += 1
	# 		end
	# 	end
	# end
#end