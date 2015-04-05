class Node
	attr_accessor :
	def initialize(args)
		
	end
	
	
end

class AirRoutes
	def initialize(args)
		connected ={}
		cost = {}
		connected['a'] = ['b','d']
		connected['b'] = ['c']
		connected['d'] = ['g']
		connected['c'] = ['e']
		connected['e'] = ['g']
		cost['a/b'] = 100
		cost['a/d'] = 150
		cost['b/c'] = 230
		cost['d/g'] = 120
		cost['c/e'] = 140
		cost['e/g'] = 160
	end
	
	def minimun_cost_between_two_nodes(node1, node2)
		if node1 == node2
			return 0 
		elsif connected[node1].nil?
			return -1
		end
		connected[node1].each do |node|
			c = minimun_cost_between_two_nodes(node, node2)
			if c == -1
			elsif new_cost["#{node}/#{node2}"].nil? 
				cost[]
			end
		end
	end
end

