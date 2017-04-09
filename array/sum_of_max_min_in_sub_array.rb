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

class SumOfMaxMinSubArray
  def initialize(arr, k)
    @arr = arr
    @k = k
    @minQ = Que.new
    @maxQ = Que.new
  end

  def sum_of_min_max
    i = 1
    @minQ.enQ(0)
    @maxQ.enQ(0)
    while (i < @k)
      while(!@minQ.empty? && @arr[@minQ.last] > @arr[i])
        #p "> "
        @minQ.deQFromEnd
      end
      @minQ.enQ(i)

      while(!@maxQ.empty? && @arr[@maxQ.last] < @arr[i])
        @maxQ.deQFromEnd
        #p "   >> "
      end
      @maxQ.enQ(i)
      i += 1
    end
    p " > min > #{@arr[@minQ.front]}, max > #{@arr[@maxQ.front]}"
    sum = @arr[@minQ.front] + @arr[@maxQ.front]

    while(i < @arr.size)
      while(!@minQ.empty? && @minQ.last < i - @k)
        @minQ.deQFromFront
      end

      while(!@minQ.empty? && @arr[@minQ.last] > @arr[i])
        @minQ.deQFromEnd
      end

      if @minQ.empty?
        sum += @arr[i]
        p "if > i > #{i}, min  > #{@arr[i]}"
      else
        sum += @arr[@minQ.front]
        p "else > i > #{i}, min  > #{@arr[@minQ.front]}"
      end
      @minQ.enQ(i)
      while(!@maxQ.empty? && @maxQ.last < i - @k)
        @maxQ.deQFromFront
      end

      while(!@maxQ.empty? && @arr[@maxQ.last] < @arr[i])
        @maxQ.deQFromEnd
      end

      if @maxQ.empty?
        sum += @arr[i]
        p "if > i > #{i}, max  > #{@arr[i]}"
      else
        sum += @arr[@maxQ.front]
        p "else > i > #{i}, max  > #{@arr[@maxQ.front]}"
      end
      @maxQ.enQ(i)
      i += 1
    end
     p sum
  end

end

o = SumOfMaxMinSubArray.new([2, 5, -1, 7, -3, -1, -2], 4)
o.sum_of_min_max