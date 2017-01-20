class BinarySearch
  def initialize(arr, element)
    @arr = arr
    @element = element
  end  

  def search(start_index, end_index)
    return -1 if start_index > end_index
    mid = (start_index + end_index)/2 
    if @arr[mid] == @element
      return @arr[mid]
    elsif @arr[mid] > @element
      return search(start_index, mid - 1)
    else
      return search(mid + 1, end_index)
    end
    
  end
end

puts 'Enter Array elements comma separated'
arr = gets.chomp.split(',').map(&:to_i)
puts 'Enter search element'
element = gets.chomp.to_i
puts BinarySearch.new(arr, element).search(0, arr.size - 1)