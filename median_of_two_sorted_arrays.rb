class MedianOfTwoSortedArrays
	def initialize(arr1, arr2)
		@arr1 = arr1
		@arr2 = arr2
	end

	# MERGE SORT ALGORITHM
	def median1
		count = 0
		i = 0
		j = 0
		return @arr2[@arr2.size/2] if @arr1.empty?
		return @arr1[@arr1.size/2] if @arr2.empty?
		m = @arr1.size
		n = @arr2.size

		while (i < m) && (j < n)
			if @arr1[i] < @arr2[j]
				temp = @arr1[i] 
				i = i + 1
			else
				temp = @arr2[j]
				j = j + 1
			end
			count = count + 1 
			return temp if count == (m + n)/2
		end

		while i < m
			count = count + 1
			return @arr1[i] if count == (m + n)/2
			i = i + 1
		end

		while j < n
			count = count + 1
			return @arr1[j] if count == (m + n)/2
			j = j + 1
		end
	end
	
	# THIS APPROACH WILL WORK IF SIZE IS EQUAL
	def median2(start1, end1, start2, end2)
		if (end1 - start1 == 1) && (end2 - start2 == 1)
			return ( [@arr1[start1], @arr2[start2]].max + [@arr1[end1], @arr2[end2]].max ) /2
		end
		med1 = @arr1[(end1 + start1)/2]
		med2 = @arr2[(end2 + start2)/2]
		if med1 == med2
			return med1
		elsif med1 > med2
			median2(start1, (end1 + start1)/2, (end2 + start2)/2, end2)
		else
			median2((end1 + start1)/2, end1, start2, (end2 + start2)/2)
		end
	end
end
arr1 = [1,4,6,9,12]
arr2 = [2,3,5,7,8]#, 10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
obj = MedianOfTwoSortedArrays.new(arr1, arr2)
#p obj.median1
p obj.median2(0, arr1.size - 1, 0, arr2.size - 1)