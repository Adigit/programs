class Node
  attr_accessor :value, :next
  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedList
  attr_accessor :head

  def initialize(head)
    @head = head
    @tail = nil
  end

  def insert_node_in_front(value)
    new_node = Node.new(value)
    new_node.next = @head
    @head = new_node
  end

  def insert_node_at_end(value)
    new_node = Node.new(value)
    @tail.next = new_node
    @tail = new_node
  end

  def insert_node_at(position, value)
    return "Couldn't insert" if position <= 0
    current = @head
    previous =  nil
    new_node = Node.new(value)
    while position > 1 && current
      previous = current
      current = current.next
      position = position - 1
    end
    return "Couldn't insert" if current.nil?
    new_node.next = current
    if previous
      previous.next = new_node
    else
      @head = new_node
    end
  end

  def delete(value)
    current = @head
    previous = nil
    while current && current.value != value
      previous = current
      current = current.next
    end
    return "Couldn't find #{value} in list." if current.nil?
    if previous
      previous.next = current.next
    else
      @head = current.next
    end
    @tail = previous if current == @tail
  end

  def push(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      @tail.next = new_node
    end
    @tail = new_node
  end

  def print_list
    current = @head
    while current do
      print "-> #{current.value} "
      current = current.next
    end
    p "\n"
  end

  def reverse
    current = @head
    previous = nil
    while !current.nil?
      temp = current.dup
      current.next = previous
      previous = current
      current = temp.next
    end
    @head = previous
  end

  class << self
    def merge(list1_head, list2_head)
      current1 = list1_head
      current2 = list2_head
      head = nil
      current = nil
      if current1.nil?
        head = current2
        return head
      elsif current2.nil?
        head = current1
        return head
      end
          
      if current1.value < current2.value
        current = current1
        current1 = current1.next
      else
        current = current2
        current2 = current2.next
      end
      head = current
      while current1 && current2
        if current1.value < current2.value
          current.next = current1
          current1 = current1.next
        else
          current.next = current2
          current2 = current2.next
        end
        current = current.next
      end
      current.next = current1.nil? ? current2 : current1
      head
    end

    def merge_sort(start_node)
      return start_node if start_node.next.nil?
      mid = mid_node(start_node)
      temp = mid.next
      mid.next = nil
      p "mid >> #{mid.inspect}"
      list1 = merge_sort(start_node)
      list2 = merge_sort(temp)
      #p ">> list1 >> #{print_list(list1)} >>"
      #p "list2 >> #{print_list(list2)} >>"
      merge(list1, list2)
    end

    def mid_node(start_node)
      return start_node if start_node.nil? || start_node.next.nil?
      slow = start_node
      fast = start_node.next
      while fast && fast.next
        slow = slow.next
        fast = fast.next.next
      end
      slow
    end

    def print_list(head)
      current = head
      while current
        print "-> #{current.value} "
        current = current.next
      end
    end

    def reverse_in_group_size(head, size)
      return head unless head || size <= 1
      current = head
      local_head = nil 
      new_head =  nil
      while current
        k = size
        previous = nil
        previous_list_head = local_head
        local_head = nil
        while k > 0 && current
          local_head = current if local_head.nil?
          temp = current.next
          current.next = previous
          previous = current
          current = temp
          k = k -1
        end
        previous_list_head.next = previous unless previous_list_head.nil?
        new_head = previous unless new_head
      end
      new_head
    end
  end
end

head = nil
# list = LinkedList.new(head)
# list.push(1)
# list.push(2)
# list.push(3)
# list.push(4)
# list.print_list
# list.insert_node_in_front(5)
# list.print
# list.insert_node_at_end(6)
# list.print

#list.insert_node_at(4, 8)
# list.print_list
# list.delete(1)
# list.print_list
# list.reverse
# list.print_list

# list1 = LinkedList.new(nil)
# list1.push(1)
# list1.push(3)
# list1.push(6)
# list1.push(8)

# list2 = LinkedList.new(nil)
# list2.push(2)
# list2.push(3)
# list2.push(5)
# list2.push(7)

# LinkedList.print_list(LinkedList.merge(list1.head, list2.head))

list = LinkedList.new(nil)
list.push(11)
list.push(2)
list.push(3)
list.push(14)
list.push(7)
list.push(9)
list.push(13)
list.push(4)
LinkedList.print_list(list.head)
p ">>>>> "
LinkedList.print_list(LinkedList.reverse_in_group_size(list.head, 3))
#LinkedList.print_list(LinkedList.merge_sort(list.head))
