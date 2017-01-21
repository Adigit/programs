class ArrayExtend
	attr_accessor :arr
	def initialize(arr)
		@arr = arr
	end

	def quick_sort(start_index = 0, end_index = @arr.size - 1)
		return if start_index >= end_index
		pivital = partition(start_index, end_index)
		quick_sort(start_index, pivital - 1)
		quick_sort(pivital + 1, end_index)
	end

	private

	def partition(start_index, end_index)
		start_index if start_index >= end_index
		pivital = @arr[end_index]
		i = start_index - 1
		j = start_index
		while j <= end_index - 1
			if @arr[j] < pivital
				i = i + 1
				@arr[i], @arr[j] = @arr[j], @arr[i]
			end
			j = j + 1
		end
		i = i + 1
		@arr[i], @arr[j] = @arr[j], @arr[i]
		i 
	end
end

arr = [3,7,1,9,2,4,3,5]
arr_obj = ArrayExtend.new(arr)
arr_obj.quick_sort
p arr_obj.arr
