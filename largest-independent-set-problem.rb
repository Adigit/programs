class Tree
	attr_accessor :left, :right, :flag
	def initialize(val)
		@left = nil
		@right = nil
		@flag = 0
		@data = val
	end
	def data
		@data
	end
end

class LargestIndependentSetProblem
	def initialize(root)
		@root = root
	end

	def largest_independent_set(root = @root)
		
		if root
			print " root >> #{root.data}\n"
			if !root.left && !root.right
				root.flag = 1
				return 1
			else
				l = largest_independent_set(root.left)
				r = largest_independent_set(root.right)
				if (root.left && root.left.flag == 1) || (root.right && root.right.flag ==1)
					return (l + r)
				else
					return (l + r + 1)
				end
			end
		else
			print " root >>> #{root}\n"
			return 0
		end
	end
	
	
end

root = Tree.new(10)
a = root.left = Tree.new(20)
b = root.right = Tree.new(30)
a.left = Tree.new(40)
c = a.right = Tree.new(50)
c.left = Tree.new(70)
c.right = Tree.new(80)
d = b.right = Tree.new(30)
d.right = Tree.new(60)
obj = LargestIndependentSetProblem.new(root)
print obj.largest_independent_set