class StringManipulation
	def initialize(arr)
		@arr = arr
		@dp_arr = Array.new(@arr.size) { |i| 1 }
	end

	def manipulate
		s = @arr.size
		return s if s <= 1
		i = 0
		while i < (s -1)
			j = i + 1
			while (i >= 0) && (j < s) && (@arr[i] == @arr[j])
				@dp_arr[i] = 0
				@dp_arr[j] = 0
				i = i - 1
				j = j + 1
			end
			i = j
		end	
		@dp_arr.inject(0){|sum,x| sum + x }
	end
end
arr = ['ab', 'aa', 'aa', 'bcd', 'ab']
arr =['tom', 'jerry', 'jerry', 'tom']
o = StringManipulation.new(arr)
p o.manipulate