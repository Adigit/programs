class HeapSort
	def initialize(arr)
		@arr = arr
	end

	def build_max_heap(size)
		i = size/2
		left = -1
		right = -1 
		while i >= 0
			left = (2*i + 1) if (2*i + 1) <= size
			right = (2*i + 2) if (2*i + 2) <= size
			if (left == -1 && right == -1)
				i = i - 1
				next
			elsif left == -1
				index = right
			elsif right == -1
				index = left
			else
				index =  @arr[left] > @arr[right] ? (2*i + 1) : (2*i + 2)
			end
			if @arr[i] < @arr[index]
				@arr[i], @arr[index] = @arr[index], @arr[i]
			end
			i = i - 1
		end
	end

	def sort
		i = @arr.size - 1
		while i >= 0
			build_max_heap(i)
			@arr[0], @arr[i] = @arr[i], @arr[0]
			i = i - 1
		end
	end

	def print_arr
		@arr
	end
end

arr = [7,8,6,5,11,2,5,10,9]
o = HeapSort.new(arr)
o.sort
p o.print_arr