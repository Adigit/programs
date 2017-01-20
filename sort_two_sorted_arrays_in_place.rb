class SortTwoSortedArraysInPlace
	def initialize(arr1, arr2)
		@arr1, @arr2 = arr1, arr2
	end

	def sort
		i = 0
		j = 0
		while i < @arr1.size && j < @arr2.size
			if @arr1[i] < @arr2[j]
				i = i + 1
			else
				@arr1[i], @arr2[j] = @arr2[j], @arr1[i]
				i = i + 1		
			end
		end
	end
end