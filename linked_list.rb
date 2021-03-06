class Node
  attr_accessor :value, :next
  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedList
  attr_accessor :head, :tail

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

  def search_node_by_value(value)
    current = @head
    while current && current.value != value
      current = current.next
    end
    return current
  end

  def contains_loop?
    head = @head
    return false if head.nil? || head.next.nil?
    slow = head
    fast = head.next
    while fast
      slow = slow.next
      fast = fast.next
      return true if fast == slow
      fast = fast.next 
      return true if fast == slow
    end
    false
  end

  def remove_loop
    head = @head
    if contains_loop?
      current = head
      while true
        slow = current
        fast = current.next
        while true
          slow = slow.next
          break if fast.next == current || fast.next == slow
          fast = fast.next
          break if fast.next == current || fast.next == slow
          fast = fast.next
        end
        if fast.next == current
          fast.next = nil
          break  
        end
        current = current.next
      end
    end
  end

  def rotate(k)
    return @head if k <= 0
    current = @head
    previous = nil
    while k >= 1 && current
      previous = current
      current = current.next
      k = k -1
    end
    return @head if current.nil?
    previous.next = nil
    new_head = current
    until current.next.nil?
      current = current.next
    end
    current.next = @head
    new_head
  end

  def absolute_sorting
    current = @head
    @negative_values_list_head = nil
    @positive_values_list_head = nil
    p_current = nil
    n_current = nil
    temp = nil
    while current
      temp = current.next
      current.next = nil
      if current.value > 0
        if @positive_values_list_head.nil?
          @positive_values_list_head = current
        else
          p_current.next = current
        end
        p_current = current
      else
        if @negative_values_list_head.nil?
          @negative_values_list_head = current
        else
          current.next = n_current
        end
        n_current = current
      end
      current = temp  
    end
    @negative_values_list_head.next = @positive_values_list_head unless @negative_values_list_head.nil?
    @head = n_current.nil? ? @positive_values_list_head : n_current
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
    
    def add(list1_head, list2_head)
      list1_head.reverse
      list2_head.reverse
      current1 = list1_head.head
      current2 = list2_head.head
      carry = 0
      result = LinkedList.new(nil)
      while current1 && current2
        sum = current1.value + current2.value + carry
        carry = sum / 10
        res = sum % 10
        result.push(res)
        current1 = current1.next
        current2 = current2.next
      end

      while current1
        sum = (carry != 0) ? (current1.value + carry) : current1.value
        carry = sum / 10
        res = sum % 10
        result.push(res)
        current1 = current1.next
      end

      while current2
        sum = (carry != 0) ? (current2.value + carry) : current2.value
        carry = sum / 10
        res = sum % 10
        result.push(res)
        current1 = current2.next
      end
      result.reverse
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

# list = LinkedList.new(nil)
# list.push(11)
# list.push(2)
# list.push(3)
# list.push(14)
# list.push(7)
# list.push(9)
# list.push(13)
# list.push(4)
# # ##### Crete loop 
# # list.tail.next = list.search_node_by_value(14)
# # ##### Remove loop
# # list.remove_loop

# LinkedList.print_list(list.head)
# p ">>>> "
# LinkedList.print_list list.rotate(3)
#LinkedList.print_list(LinkedList.reverse_in_group_size(list.head, 3))
#LinkedList.print_list(LinkedList.merge_sort(list.head))

# list1 = LinkedList.new(nil)
# list1.push(2)
# list1.push(8)
# list1.push(9)

# list2 = LinkedList.new(nil)
# list2.push(3)
# list2.push(4)
# list2.push(7)

# LinkedList.print_list LinkedList.add(list1, list2)

list = LinkedList.new(nil)
list.push(1)
list.push(-2)
list.push(-3)
list.push(4)
list.push(-7)
list.push(9)
list.push(13)
list.push(-14)
LinkedList.print_list list.absolute_sorting