class NodeObj
  attr_accessor :value, :frequency, :index, :left, :right
  def initialize(value, index)
    @value = value
    @frequency =  1
    @index =  index
    @left = nil
    @right = nil
  end
end

class BSTree
  def initialize(node)
    @root = node
  end

  def insert(root = @root, node)
    if root.value < node.value
      if root.right.nil?
        root.right = node
        return
      end
      insert(root.right, node)
    elsif root.value > node.value
      if root.left.nil?
        root.left = node
        return
      end
      root.left = insert(root.left, node)
    elsif root.value == node.value
      root.frequency += 1
    end
  end

  def inOrderTraversal(node = @root)
    return if node.nil?
    inOrderTraversal(node.left)
    p "node > #{node.value.inspect} >"
    inOrderTraversal(node.right)
  end
end

class SortElementBYFrequency
  def initialize(arr)
    @arr = arr
    @node_arr = []
  end

  def build_node_arr
    node = {}
    @arr.each_with_index do |a, i|
      if node[a].nil?
        node[a] = {frequency: 1, index: i}
      else
        node[a][:frequency] += 1
      end
    end
    node.each do |k, v|
      t = v
      t[:value] = k
      @node_arr << t
    end
    p @node_arr
  end

  def modified_merge_sort(l, r)
    if l < r
      m = l + (r - l)/2
      modified_merge_sort(l, m)
      modified_merge_sort(m+1, r)
      modified_merge(l, m, r)
    end

  end

  def modified_merge(l,m, r)
    p "l > #{l}, m > #{m}, r > #{r}"
    tmp = []
    left = @node_arr[l..m]
    right = @node_arr[(m+1)..r]
    p "left > #{left}, right > #{right}"
    i = l
    j = m + 1
    while(i <= m && j <= r)
      p "i > #{i}, j > #{j}"
      if @node_arr[i][:frequency] <= @node_arr[j][:frequency]
        tmp << @node_arr[i]
        i += 1
      else
        tmp << @node_arr[j]
        j += 1
      end
    end
    
    while(i <= m)
      tmp << @node_arr[i]
      i += 1
    end

    while(j <= r)
      tmp << @node_arr[j]
      j += 1
    end

    i = 0
    while(i + l <= r)
      @node_arr[i + l] = tmp[i]
      i += 1
    end
  end

  def sort_by_freq
    build_node_arr
    modified_merge_sort(0, @node_arr.size - 1)
    i = 0
    @node_arr.each do |n|
      n[:frequency].times do |x|
        @arr[i] = n[:value]
        i += 1
      end
    end
    p @arr
  end

  ####### BST approach ########

  def create_bst
    bst = BSTree.new(NodeObj.new(@arr.first, 0))
    @arr[1..@arr.size].each_with_index do |a, i|
      i += 1
      bst.insert(NodeObj.new(a, i))
    end
    bst.inOrderTraversal
  end
end

o = SortElementBYFrequency.new([2,5,2,8,5,6,8,8])
#o.sort_by_freq
o.create_bst

