class Node
  attr_accessor :value, :next, :previous
  def initialize(value)
    @value = value
    @next = nil
    @previous = nil
  end
end

class DoublyLinkedList
  
  class << self
    def print_list(head)
      return head unless head
      current = head
      while current
        print "-> #{current.value} "
        current = current.next
      end
    end
  end

  attr_accessor :head, :tail
  
  def initialize(head = nil)
    @head = head
    @tail = nil
  end

  def push(value)
    new_node = Node.new(value)
    @head = new_node if @head.nil?
    unless @tail.nil?
      @tail.next = new_node
      new_node.previous = @tail
    end
    @tail = new_node
  end

  def reverse
    return @head unless @head
    current = @head
    @tail = current
    while current
      temp = current.next
      current.next = current.previous
      current.previous = temp
      @head = current if temp.nil?      
      current = temp
    end
    @head
  end

  def quick_sort(start_node = @head, end_node = @tail)
    return @head if start_node == end_node || start_node.nil? || end_node.nil? 
    start_node, pivot, end_node = partition(start_node, end_node)
    p ">> pivot >> #{pivot.value}"
    DoublyLinkedList.print_list(@head)
    quick_sort(start_node, pivot.previous)
    quick_sort(pivot.next, end_node)
  end
  
  #private

  def partition(start_node = @head, end_node = @tail)
    p ">> start_node >> #{start_node.value}"
    p " >> end_node >> #{end_node.value}"
    return start_node if start_node == end_node
    small_head = nil
    large_head = nil
    i = nil
    j = nil
    current = start_node
    pivot = end_node
    while current && current != end_node
      p ">> current >> #{current.value} >> pivot >> #{pivot.value}"
      if current.value <= pivot.value
        if small_head.nil?
          small_head = current
          current.previous.next = nil unless current.previous.nil?
          small_head.previous =  nil
          j = small_head
        else
          j.next = current
          current.previous = j 
          j = current
        end
      else
        if large_head.nil?
          large_head = current
          current.previous.next = nil unless current.previous.nil?
          large_head.previous =  nil
          i = large_head
        else
          i.next = current
          current.previous = i 
          i = current
        end
      end
      current = current.next
    end
    i.next = nil if i
    if j
      j.next = current
    else
      j = current
    end
    current.previous = j 
    current.next = large_head
    large_head.previous = current if large_head
    #@head = small_head
    [small_head, current, large_head]
  end
end

# list = DoublyLinkedList.new
# list.push(1)
# list.push(2)
# list.push(3)
# list.push(4)
# DoublyLinkedList.print_list(list.head)
# p ">>>>"
# DoublyLinkedList.print_list list.reverse

list = DoublyLinkedList.new
list.push(13)
list.push(8)
list.push(1)
list.push(6)
list.push(5)
list.push(11)
list.push(9)
list.push(10)
#DoublyLinkedList.print_list(list.head)
list.quick_sort
#list.partition
#DoublyLinkedList.print_list(list.head)


