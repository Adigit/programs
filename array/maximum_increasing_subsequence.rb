class MaximumIncreasingSubsequence

  def initialize(arr)
    @arr = arr
    @dp_arr = [1]
  end

  def max_inc_subseq_length
    max = 1
    @arr.each_with_index do |a, i|
      if i == 0
        max = a
        next
      end
      last_index = i - 1
      if a > @arr[last_index]
        sum = @dp_arr[last_index] + a
      else
        sum = loop_up_array(last_index, a)
      end
      @dp_arr << sum
      max = sum if max < sum
      p "a > #{a}, i > #{i}, max > #{max}"
    end
    max
  end

  def loop_up_array(index, value)
    while index >= 0 && @arr[index] >= value
      index -= 1
    end
    index < 0 ? value : @dp_arr[index] + value
  end

end

o = MaximumIncreasingSubsequence.new([1, 101, 2, 3, 100, 4, 5, 110])
p o.max_inc_subseq_length