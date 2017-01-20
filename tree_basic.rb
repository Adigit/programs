class TreeBasic
	attr_accessor :value, :children
	
	def initialize(value = nil)
		@value = value
		@children = []
	end
		
	def preOrder(root, k, ansestor)
		if  !root || root.value == k 
			return root 
		end
		ansestor.push root
		top = ansestor.last
		left = preOrder(top.children[0], k, ansestor)
		return left if left
		right = preOrder(root.children[1], k, ansestor)
		return right if right
		ansestor.pop
		return nil
	end

	def closest_leaf k
		ansestor = Array.new
		leaf = TreeBasic.new
		node = preOrder(self, k, ansestor)
		print "\n ansestor array>>> #{ansestor.collect(&:value)}\n >>> node searched >> #{node.value}\n"
		closest_in_sub_tree = find_closest_leaf(node, 0, 0)
		print "\n >>> closest_in_sub_tree >>> #{closest_in_sub_tree}\n"
		closest_in_ansestor_sub_tree = []
		ansestor.each do |root|
			closest_in_ansestor_sub_tree << find_closest_leaf(root, 0, 0)
		end
		print "\n closest_in_ansestor_sub_tree >>>> #{closest_in_ansestor_sub_tree}\n"
	end

	def find_closest_leaf(root, distance, min_distance)
		if !root 
			return [0, root]
		end
		left = find_closest_leaf(root.children[0], distance + 1, min_distance)
		right = find_closest_leaf(root.children[1], distance + 1, min_distance)
		#print "\n >>>> #{root.value} >>> #{left} >>> #{right}"
		if left[0] == 0 && right[0] == 0 && min_distance <= distance
			min_distance = distance
			return [min_distance, root]
		end
		return (left[0] < right[0] && left[1]) ? left : right
	end
end

head = a = TreeBasic.new 'a'
a.children = [b = TreeBasic.new('b'), c = TreeBasic.new('c')]
b.children = [d = TreeBasic.new('d'), e = TreeBasic.new('e')]
c.children = [f = TreeBasic.new('f'), g =TreeBasic.new('g')]
d.children = [nil, h = TreeBasic.new('h')]
e.children = [i = TreeBasic.new('i'), nil]
f.children = [j = TreeBasic.new('j'), k = TreeBasic.new('k')]
g.children = [l = TreeBasic.new('l'), m = TreeBasic.new('m')]
h.children = [nil, nil]
i.children = [nil, nil]
j.children = [nil, n = TreeBasic.new('n')]
k.children = [nil, nil]
l.children = [nil, nil]
m.children = [nil, o = TreeBasic.new('o')]
n.children = [nil, nil]
o.children = [nil, nil]

obj = TreeBasic.new
head.closest_leaf('f')

 
