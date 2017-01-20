class CuttingARod
	def initialize(len, val)
		@len = len
		@val = val
		@dp_arr = Array.new(len.size) 
	end
	
	def max_profit
		i = 0
		j = 0
		@val.each do |l|
			p ">> l >> #{l}"
			temp = [l]
			j = i-1
			p ">> j >> #{j}"
			while j >=0 
				temp << @dp_arr[j] + @dp_arr[i-j-1] 
				j -= 1
			end
			p ">> temp >> #{temp}"
			@dp_arr[i] = temp.max
			p ">> dp_arr >> #{@dp_arr}"
			i += 1

		end
		return @dp_arr.last
	end
	
end
obj = CuttingARod.new([1,2,3,4,5,6,7,8], [1, 5, 8, 9, 10, 17, 17, 20])
op = obj.max_profit
print ">>> op >> #{op}\n"