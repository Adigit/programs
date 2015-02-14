class KnapsackProblem
	def initialize(values, weights)
		@weights = weights
		@values = values
		@dp_arr = Array.new(weights.size)
	end
	
	def knap_sack(j, w)
		return 0 if w <= 0 || j < 0 
		return @values[j] if j == 0
		return @dp_arr[j] if !@dp_arr[j].nil?
		print ">>>> #{j}\n"
		including_last = @values[j] + knap_sack(j - 1, w - @weights[j])
		excluding_last = knap_sack(j - 1, w)
		@dp_arr[j] = [including_last, excluding_last].max
		print ">> j >> #{j} >> w >> #{w} >> including_last >> #{including_last} >> excluding_last >> #{excluding_last} >> dp_arr >> #{@dp_arr[j]}\n"
		return @dp_arr[j]
	end
	
end
values = [60, 50, 100, 120, 160, 250]
weights = [10, 15, 20, 30, 40, 45]
obj = KnapsackProblem.new(values, weights)
op = obj.knap_sack(weights.size - 1, 50)
print "output >> #{op}\n"