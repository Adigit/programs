#QUESTION
#####################################################################################################

# We have nodes as the airports of the country and a link between nodes if  there is a flight 
#between the nodes. 
# Now we associate costs with these links as the aerial distance between the airports.

# Suppose we have a Bangalore - ( 2130) -> Delhi link, but no Bangalore -> Jammu link, 
#but Delhi - ( 600 )-> Jammu link, then to go from Bangalore  -> Jammu, we have to traverse two links, 
#Bangalore  - (2130)-> Delhi  - ( 600) -> Jammu, meaning a total of 2730 kms.. 

# Now there can be links like Bangalore - ( 2380 )-> Chandigarh - ( 344)-> Jammu,  
#Bangalore - ( 2584 )-> Amritsar - ( 212 )-> Jammu, etc..

# Now given that info , we need to answer this query::

# Given two nodes as the input, list all the possible routes between the two sorted by distance, 
#as in we need to output the shortest path between the nodes and the distance ( cost ) .. 

# What we mean here is that if one asks for Bangalore -> Delhi, we just print 2130 and stop, 

#we don't need to go to the other traversals, which could be like  Bangalore -> Chandigarh -> Delhi, 
#an in we stop at the shortest path, which is of length 1 in this casse. 

# For say Bangalore -.> Jammu, we list all the paths with length 2, as in Bangalore -> Delhi  -> Jammu, 
#Bangalore -> Amritsar  -> Jammu,  Bangalore -> Chandigarh  -> Jammu, etc sorted on the distance , 
#but of length 2. 

# We  will max the length at 3, which means that if there is a path with length more than 3 between nodes, we return null..

# A graph based solution also is fine, but would be great if we don't go with that.. Maybe use data structures, say hashes ( dicts ) , lists , sets to arrive at the solution..

# ANSWER 
##################################################################################################
class AirRoutes
	@@connected ={} # HASH FOR CONNECTED NODES
	@@distance = {} # DISTANCE HASH BETWEEN TWO NODES
	@@final = {} # FINAL HASH TO SHOW OUTPUT 
	STEP = 3

	def initialize
		# WE CAN INPUT FROM TERMINAL AS WELL BUT DUE TO LACK OF TIME, INITIALIZE DIRECTLY.
		# FOR TESTING AND VALIDATION WE CAN CHANGE THE HASH FUNCTIONS 

		@@connected['a'] = ['b','d'] # MEANS NODE 'a' IS CONNECTED TO 'b' AND 'c', SIMILARLY REST ONES 
		@@connected['b'] = ['c','k']
		@@connected['d'] = ['g', 'p']
		@@connected['c'] = ['e', 'f', 'g']
		@@connected['e'] = ['g']
		@@connected['p'] = ['g']
		@@connected['k'] = ['g']

		@@distance['a/b'] = 100 # DISTANCE BETWEEN 'a' AND 'b'
		@@distance['a/d'] = 10
		@@distance['b/c'] = 230
		@@distance['b/k'] = 130
		@@distance['c/e'] = 140
		@@distance['c/f'] = 110
		@@distance['c/g'] = 190
		@@distance['d/g'] = 120
		@@distance['d/p'] = 10
		@@distance['e/g'] = 160
		@@distance['k/g'] = 120
		@@distance['p/g'] = 90
	end
	
	# FUNCTION COMPUTES REQUIRED HASH FUNCTION, WE CAN USE THAT HASH TO GET OUTPUT
	def air_route_between_nodes(node1, node2, path, step, distance)
		if node1 == node2
			if @@final[step].nil? 
				@@final[step] = {"#{distance}" => []}
			elsif @@final[step]["#{distance}"].nil?
				@@final[step]["#{distance}"] = []
			end
			@@final[step]["#{distance}"] <<  path.dup 
			return 
		elsif @@connected[node1].nil? || step >= STEP
			return
		end
		@@connected[node1].each do |node|
			s = step + 1
			p = (path << node)
			cc = @@distance["#{node1}/#{node}"].to_i + distance
			air_route_between_nodes(node, node2, p, s, cc)
			path.pop
		end
		return
	end

	def print_air_route(node1, node2)
		if node1 == node2
			puts "Source and destination both are same."
		elsif !@@distance["#{node1}/#{node2}"].nil?
			puts "Distance between #{node1} and #{node2} is #{@@distance["#{node1}/#{node2}"]}"
		else
			air_route_between_nodes(node1,node2,[node1], 0, 0)
			
			if !@@final[2].nil?
				h = @@final[2]
				h.each do |d|
					puts "Distance >> #{d[0]} and path >> #{d[1][0]}"
				end
			elsif !@@final[3].nil?
				h = @@final[3].sort
				h.each do |d|
					puts "Distance >> #{d[0]} and path >> #{d[1][0]}"
				end	
			else
				puts "Sorry, No route found between cities. Either there is no route or route has more than #{STEP} steps. "
			end
		end
	end
end

obj = AirRoutes.new
obj.print_air_route('b','g') # GET OUTPUT FOR TWO NODES/CITIES SAY 'b' AND 'g'