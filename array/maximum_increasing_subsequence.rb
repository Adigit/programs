class MaximumIncreasingSubsequence

  def initialize(arr)
    @arr = arr
    @dp_arr = [1]
    @dp_2d_arr = Array.new(@arr.size) {Array.new()}
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

  def print_maximum_inc_subseq
    max = 0
    sum  = 0
    max_sum_index = -1
    @arr.each_with_index do |a, i|
      if i == 0
        @dp_2d_arr[i] << a
        next
      end
      if @dp_2d_arr[i - 1].last < a
        sum = copy(i-1, i,a)
      else
        j = i - 1
        while(j >= 0 && @dp_2d_arr[j].last > a)
          j -= 1
        end
        sum = copy(j, i, a)
      end
      if (sum >= max)
        max = sum
        max_sum_index = i
      end
    end
    p @dp_2d_arr[max_sum_index]
    p max
  end

  def copy(index, j, element)
    #p "> index > #{index}, j > #{j}, element > #{element}, @dp_2d_arr > #{@dp_2d_arr} "
    tmp = []
    sum = 0
    until @dp_2d_arr[index].empty?
      t = @dp_2d_arr[index].pop
      sum += t
      tmp << t
    end
    s = tmp.size - 1
    while(s >= 0)
      @dp_2d_arr[index].push(tmp[s])
      @dp_2d_arr[j].push(tmp[s])
      s -= 1
    end
    @dp_2d_arr[j].push(element)
    sum += element
    sum
  end
end

o = MaximumIncreasingSubsequence.new([1, 1010, 2, 3, 100, 4, 5, 110])
#p o.max_inc_subseq_length
o.print_maximum_inc_subseq