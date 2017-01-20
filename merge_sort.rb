class MergeSort
	
	def initialize(arr)
		@arr = arr
	end

	def sort(start_index, end_index)
		return [@arr[start_index]] if start_index >= end_index
		mid = start_index + (end_index - start_index)/2
		arr1 = sort(start_index, mid)
		arr2 = sort(mid + 1, end_index)
		merge(arr1, arr2)
	end

	# Merging with extra space 
	def merge(arr1, arr2)
		temp = []
		i = 0
		j = 0
		while (i < arr1.size && j < arr2.size) do
			if arr1[i] < arr2[j]
				temp << arr1[i]
				i = i + 1
			else
				temp << arr2[j]
				j = j + 1
		end

		while i < arr1.size
			temp << arr1[i]
			i = i + 1
		end

		while j < arr2.size
			temp << arr2[j]
			j = j + 1
		end

		temp
	end
end

arr = [3,4,1,5,2,10,3,5,1,8,9]
p MergeSort.new(arr).sort(0, arr.size - 1)