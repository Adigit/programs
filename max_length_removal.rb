class MaxLengthRemoval
  def initialize(arr)
    @arr = arr
  end

  def max_lenght
    i = 0
    j = 1
    s = @arr.size - 1
    max = 0
    max_so_far = 0
    while j <= s
      if (j - i + 1)%3 == 0
        if @arr[i] == 1 && @arr[j] == 0
          max_so_far += 3
          max = max_so_far if max_so_far > max
          i = ((i - 1) >= 0) ? (i - 1) : j
        else
          i = j
          max_so_far = 0
        end
          j +=  1
      else
        if @arr[i] == 1 && @arr[j] == 0
          j = j + 1
        elsif @arr[i] == 0 && @arr[j] == 0
          i = ((i - 1) >= 0) ? (i - 1) : j
        else
          i = i + 1
          j = j + 1
        end
      end
    end
    max 
  end
end

o = MaxLengthRemoval.new([1,0,1,1,1])#,0,0,0,0,0,1,1,1,0,0,0,0,0,0])
p o.max_lenght