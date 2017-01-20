class SubsetSumProblem
	def initialize(arr, sum)
		@arr = arr
		@sum = sum
	end
	
	def subset_sum_recur(i = 0, set_arr = [], sum = @sum)
		print "Set >> #{set_arr}\n" if sum == 0
		@arr[i..@arr.size].each do |a|
			i += 1
			#print ">> i >> #{i-1}\n"
			next if a > sum
			break if sum <= 0
			set_arr << a
			remaining_sum = sum - a
			#print "arr >> #{set_arr} >> sum >> #{remaining_sum} >> i >> #{i-1}\n"
			subset_sum_recur(i, set_arr.dup, remaining_sum)
			set_arr = set_arr - [a]
		end
	end
	
end
arr = [3, 34, 4, 6, 5, 2]
sum = 10
obj = SubsetSumProblem.new arr, sum
obj.subset_sum_recur
