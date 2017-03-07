class MaximumSumPathAcrossTwoArray
  def initialize(arr1, arr2)
    @arr1 = arr1
    @arr2 = arr2
  end

  def max_sum
    sum = 0
    sum1 = 0
    sum2 = 0
    i = 0
    j = 0
    while i < @arr1.size && j < @arr2.size
      if @arr1[i] < @arr2[j]
        sum1 += @arr1[i]
        i += 1
      elsif @arr1[i] > @arr2[j]
        sum2 += @arr2[j]
        j += 1
      else
        sum1 += @arr1[i]
        sum2 += @arr2[j]
        sum += [sum1, sum2].max
        sum1 = 0
        sum2 = 0
        i += 1
        j += 1
      end
    end
    while i < @arr1.size
      sum1 += @arr1[i]
      i += 1
    end

    while j < @arr2.size
      sum2 += @arr2[j]
      j += 1
    end
    sum += [sum1, sum2].max
  end
end

arr1 = [2, 3, 7, 10, 12, 15, 30, 34]
arr2 = [1, 5, 7, 8, 10, 15, 16, 19]

obj = MaximumSumPathAcrossTwoArray.new(arr1, arr2)
p obj.max_sum