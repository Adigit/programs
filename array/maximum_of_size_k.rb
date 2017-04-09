class Que
  def initialize()
    @arr = []
    @start = 0
    @end = 0
  end

  def enQ(element)
    @arr[@end] = element
    @end += 1
  end

  def deQFromEnd
    @end -= 1
  end

  def deQFromFront
    @start += 1
  end

  def last
    @arr[@end - 1]
  end

  def front
    @arr[@start]
  end

  def empty?
    @end <= @start
  end

end

class MaximumOfSizeK
  def initialize(arr, k)
    @arr = arr
    @k = k
    @q = Que.new
  end

  def print_max
    i = 1
    @q.enQ(0)
    while i < @k
      while (!@q.empty? && @arr[@q.last] < @arr[i])

        @q.deQFromEnd
      end
      @q.enQ(i)
      i += 1
    end
    p " > #{@arr[@q.front]}"
    while i < @arr.size
      while (!@q.empty? && @q.front <= (i - @k))
        @q.deQFromFront
      end

      while (!@q.empty? && @arr[@q.last] < @arr[i])
        @q.deQFromEnd
      end

      #@q.enQ(i)
      if @q.empty?
        p " > #{@arr[i]}"
      else
        p " > #{@arr[@q.front]} "
      end
      @q.enQ(i)
      i += 1
    end

  end

end
o = MaximumOfSizeK.new([8, 5, 10, 7, 9, 4, 15, 12, 90, 13], 4)
o.print_max