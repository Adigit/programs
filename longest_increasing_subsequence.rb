class LongestIncreasingSubsequence
	def initialize(args)
		@arr = args	
	end
	
	def find_pre(dp_arr, arr, element)
		index = 0
		max =  -1
		dp_arr.each do |a|
			if  max < a && arr[index] < element
				max = a
			end
			index += 1
		end
		return ((max != -1) ? max : 0)
	end

	def lic
		arr = @arr
		return arr.size if arr.size <= 1
		dp_arr = [1]
		pre = arr.first
		index = 1
		arr[1..(arr.size)].each do |a|
			dp_arr << find_pre(dp_arr, arr[0..index], a) + 1
			index += 1
		end
		print dp_arr.max
	end
end

obj = LongestIncreasingSubsequence.new([10, 22, 19, 33, 21, 5, 41, 6])
obj.lic