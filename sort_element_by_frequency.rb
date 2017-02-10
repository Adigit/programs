class SortElementByFrequency
	def initialize(arr)
		@arr = arr
		@index = []
		arr.each_with_index {|v, i| @index << i}
	end

	def modified_merge_sort(arr1 = @arr, arr2 = @index, start_index = 0, end_index = @arr.size - 1)
		return [arr1[end_index]] if start_index >= end_index
		p ">> start_index >> #{start_index} >> end_index >> #{end_index}"
		mid = (start_index + end_index)/2
		modified_merge_sort(arr1, arr2, start_index, mid)
		modified_merge_sort(arr1, arr2, mid + 1, end_index)
		return modified_merge(start_index,  mid, mid + 1, end_index, arr1, arr2)
	end

	def modified_merge(s1, e1, s2, e2, arr1, arr2)
		temp1 = []
		temp2 = []
		i = s1
		j = s2
		while i <= e1 && j <= e2
			if arr1[i] <= arr1[j]
				temp1 << arr1[i]
				temp2 << arr2[i]
				i += 1
			else
				temp1 << arr1[j]
				temp2 << arr2[j]
				j += 1
			end
		end

		while i <= e1
			temp1 << arr1[i]
			temp2 << arr2[i]
			i += 1
		end

		while j <= e2
			temp1 << arr1[j]
			temp2 << arr2[j]
			j += 1
		end
		i = 0
		while i <= (e2 - s1)
			arr1[s1 + i] = temp1[i]
			arr2[s1 + i] = temp2[i]
			i += 1
		end
		arr1[s1, e2]
	end

	def print_arr
		p @arr
		p @index
	end
end
arr = [2, 5, 8, 2, 5, 6, 8, 8]
o = SortElementByFrequency.new(arr)
o.modified_merge_sort
o.print_arr