class MinimumStepsToGetDesiredArray
  def initialize(arr)
    @arr = arr
    @min = arr.min #Order n 
    @size = arr.size 
    @sum = 0
    arr.each {|x| @sum += x } #order n
  end

  def operations_for_min(val)
    i = 1
    opr = 0
    while i != val
      if 2*i > val
        opr += size*(val - i)
        i = val
      else 
        i = 2*i
        opr += 1
      end
    end
    opr
  end

  def minnimum_steps
    opr = 0
    opr = @size + operations_for_min(@min) + @sum - @size*@min
    opr
  end
end
obj = MinimumStepsToGetDesiredArray.new([2,1])
p obj.minnimum_steps