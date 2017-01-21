class Node
  attr_accessor :value, :next, :previous
  def initialize(value)
    @value = value
    @next = nil
    @previous = nil
  end
end

class DoublyLinkedList
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
end

list = DoublyLinkedList.new
list.push(1)
list.push(2)
list.push(3)
list.push(4)
DoublyLinkedList.print_list(list.head)
p ">>>>"
DoublyLinkedList.print_list list.reverse
