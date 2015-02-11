class MinCostPath

	def initialize(cost_arr)
		@cost_arr = cost_arr
		@dp_arr = Array.new(cost_arr.size) { Array.new(cost_arr.size) }
	end
		
	def find_min_cost(i, j)
		
		return 100 if i< 0 || j < 0 || i > 2 || j > 2 
		# return some very big val say infinite but for now taking 100 as all values in cost arr
		# is less than 100
		return @cost_arr[i][j] if i == 2 && j == 2
		return @dp_arr[i][j] if !@dp_arr[i][j].nil?
		down_move = find_min_cost(i+1, j)
		right_move = find_min_cost(i, j+1)
		buttom_diagonal_move = find_min_cost(i+1, j+1)
		min_cost = [down_move, right_move, buttom_diagonal_move].min
		@dp_arr[i][j] = min_cost + @cost_arr[i][j]

	end

	def print_dp_arr
		@dp_arr.each do |arr|
			print "#{arr}\n"
		end
	end
end

obj = MinCostPath.new([[1, 2, 3], [4, 8, 2], [1, 5, 3]])
obj.find_min_cost(0, 0)
obj.print_dp_arr