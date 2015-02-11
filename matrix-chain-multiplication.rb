class MatrixChainMultiplication
	def initialize(arr)
		@arr = arr
		@dp_arr = Array.new(arr.size - 1) { Array.new(arr.size - 1) }
	end
	
	def prod(i, j)
		print " i >> #{i} >> j >> #{j}\n"	
		# Base case when size =2 
		if ((j-i) ==1)
			@dp_arr[i][j] = @arr[i]*@arr[j]*@arr[j+1] 
		else
			@dp_arr[i][j] = [(@arr[i]*@arr[j])*@arr[j+1], @arr[i]*(@arr[i+1]*@arr[j+1])].min
		end
	end

	def min_cost
		i = 0
		size = 2
		while size < @arr.size 
			print ">>>>>>>>>>>>>>>>> size >> #{size}\n"
			j = 0
			i = 0
			while j < @arr.size - 2 
				j = i + size -1
				prod(i, j)
				i += 1
			end
			size += 1
			
		end
	end

	def print_dp
		@dp_arr.each do |arr|
			print  "#{arr}\n"
		end
	end

	def mincost
		 print " Minimum cost to multiple matrix >> #{@dp_arr.first.last}\n"
	end
end

obj = MatrixChainMultiplication.new([40, 20, 30, 10, 30, 40, 20])
obj.min_cost
obj.print_dp
obj.mincost