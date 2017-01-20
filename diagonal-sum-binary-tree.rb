require 'thread'

class TreeNode
	attr_accessor :valve, :children
	
	def initialize(value)
		@value = value
		@children = []
	end

	def value
		@value
	end

	def children
		@children
	end

end

class DiagonalSumBinaryTree
	def initialize(args ={})
		@q = Queue.new
	end
	
	def traverse_right(root, sum =0)
		return [0, root] if root.nil?
		@q.enq root
		sum = root.value
		val = traverse_right(root.children[1], sum)
		print "\n >>> val >>>>> #{val[0].inspect} \n"
		sum += val[0]
		return [sum, root]
	end
	def diagonalSum(root)
		sum = []
		sum << traverse_right(root, 0)[0]
		print "\n >>> sum >>>> #{sum}\n"
		print "\n >>> Queue >>>> #{@q.inspect}\n"
		while !@q.empty? do
			root = @q.deq
			sum << traverse_right(root, 0)[0]
		end
		print "\n >>> sum >>>> #{sum}\n"
	end

end

head = a = TreeNode.new 1
a.children = [b = TreeNode.new(2), c = TreeNode.new(3)]
b.children = [d = TreeNode.new(4), e = TreeNode.new(5)]
c.children = [f = TreeNode.new(6), g =TreeNode.new(7)]
d.children = [nil, h = TreeNode.new(8)]
e.children = [i = TreeNode.new(9), nil]
f.children = [j = TreeNode.new(10), k = TreeNode.new(11)]
g.children = [l = TreeNode.new(12), m = TreeNode.new(13)]
h.children = [nil, nil]
i.children = [nil, nil]
j.children = [nil, n = TreeNode.new(14)]
k.children = [nil, nil]
l.children = [nil, nil]
m.children = [nil, o = TreeNode.new(15)]
n.children = [nil, nil]
o.children = [nil, nil]

print "\n >>>> head >>>> #{head.inspect}\n"
obj = DiagonalSumBinaryTree.new
obj.diagonalSum(head)