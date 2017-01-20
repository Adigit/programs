# THIS IS RUBY PROGRAM
# TO RUN THIS, CD UPTO THE FOLDER WHICH CONTAINS tree_operation.rb FILE
# AFTER THAT JUST TYPE ruby tree_operation.rb
# THIS IS ON LINUX SYSTEM WITH RUBY INSTALLED

class TreeNode
    attr_accessor :value, :left, :right
    def initialize val,left,right
        @value = val
        @left = left
        @right = right
    end
end

class BSTree
    
    def initialize val
        @root = TreeNode.new(val,nil,nil)   
    end
 	
 	# Insert value in BSTee   
    def insert(value)
        current_node = @root
        while nil != current_node
            if (value < current_node.value) && (current_node.left == nil)
                current_node.left = TreeNode.new(value,nil,nil)
            elsif  (value > current_node.value) && (current_node.right == nil)
                current_node.right = TreeNode.new(value,nil,nil)
            elsif (value < current_node.value)
                current_node = current_node.left
            elsif (value > current_node.value)
                current_node = current_node.right
            else
                return
            end
        end
    end

   	# Search for a value, returns 1 if found else 0
    def search(current_node = @root ,value)
    	if current_node
	    	if current_node.value == value
	    		return 1
	    	elsif current_node.value > value
	    		search(current_node.left, value)
	    	elsif current_node.value < value
	    		search(current_node.right, value)
	    	end
    	else
    		return 0
    	end
    end

    # Prints level order traversal via iteration and returns last level(height of tree)
    # We can write seperate function for height also
    # Level starts from 1, means root is at level 1
    def levelOrderTraversal(current_node = @root)
    	return "Tree is empty" if !current_node
    	level = 1
    	queue = Array.new
    	queue.push current_node
    	queue.push '$' # To identify end of level
    	p "Level = #{level}"
    	while queue.size != 1
    		top_element = queue.shift
    		if top_element != '$'
	    		p top_element.value
	    		queue.push top_element.left if top_element.left
	    		queue.push top_element.right if top_element.right
	    	else
	    		level += 1
	    		p "Level = #{level}"
	    		queue.push top_element
	    	end
    	end
    	return level
    end

    # Get inorder successor of node 
    def successor_value(node)
        while !node.left.nil?
         node = node.left
        end
        return node
    end
 
 	# Delete node with specific key if found else do nothing  	
   	def deleteNode(current_node = @root, key)
	    return current_node if !current_node
      	if key < current_node.value
       		current_node.left = deleteNode(current_node.left, key)
 		elsif key > current_node.value
        	current_node.right = deleteNode(current_node.right, key)
 	    else
            if (current_node.left.nil?)
                temp = current_node.right
        	    return temp
       	  	elsif (current_node.right.nil?)
                temp = current_node.left
        	    return temp
        	end
            temp = successor_value(current_node.right)
            current_node.value = temp.value
            current_node.right = deleteNode(current_node.right, temp.value)
        end
    	return current_node
	end    

	# Counts leaf nodes
	def leafNodeCount(current_node = @root)
		return 0 if current_node.nil?
		return 1 if current_node.left.nil? && current_node.right.nil?
        return leafNodeCount(current_node.left) + leafNodeCount(current_node.right)
	end
end

bst = BSTree.new(100)
bst.insert(150)
bst.insert(20)
bst.insert(50)
bst.insert(10)
bst.insert(180)
bst.insert(170)	
bst.insert(40)
bst.insert(50)
bst.insert(30)
bst.insert(90)
bst.insert(110)
bst.insert(60)
bst.insert(80)

p bst.search(90) # search for 90
bst.levelOrderTraversal # Before deletion
bst.deleteNode(10) # delete node with value 10
bst.levelOrderTraversal # After deletion
p bst.leafNodeCount # Leaf node count
p " Height of tree >> #{bst.levelOrderTraversal}" # prints height of the tree

