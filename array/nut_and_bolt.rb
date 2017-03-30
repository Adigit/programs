class NutAndBolt

  def initialize
    @nuts = ['#', '$', '%', '&', '@', '^']
    @bolt = ['$', '%', '&', '^', '@', '#']
    match(@nuts, @bolt, 0, 5)
  end

  def match(nuts, bolt, low, high)
    return if low >= high
    pivot = partition(nuts, low, high, bolt[high])
    partition(bolt, low, high, nuts[pivot])
    match(nuts, bolt, low, pivot - 1)
    match(nuts, bolt, pivot + 1, high)
  end

  def partition(arr, l, r, pivot)
    i = l
    j = l - 1
    while i < r
      if arr[i] < pivot
        j = j + 1
        arr[j], arr[i] = arr[i], arr[j]
      elsif arr[i] == pivot
        arr[r], pivot = pivot, arr[r]
        i = i -1
      end
      i = i + 1
    end
    j = j + 1
    arr[j], pivot = pivot, arr[j]
    j
  end

  def print_arrays
    p ">> NUTS >> #{@nuts}"
    p ">> BOLTS >> #{@bolt}"
  end
end
obj = NutAndBolt.new.print_arrays