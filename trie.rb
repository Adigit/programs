class TrieNode
	attr_accessor :is_leaf, :char_arr
	def initialize
		@is_leaf = false
		@char_arr = Array.new(26)
	end
end

class Trie
	def initialize(root)
		@root = root
	end

	def insert(value)
		node = @root
		char_index = -1
		value.each_byte do |c|
			char_index = c - 97
			if node.char_arr[char_index].nil?
				new_node = TrieNode.new
				node.char_arr[char_index] = new_node
				node = new_node
			else
				node = node.char_arr[char_index]
			end
		end	
		node.is_leaf = true
	end

	def search(key)
		node = @root
		key.each_byte do |c|
			char_index = c - 97
			next_node = node.char_arr[char_index]
			return false if next_node.nil?
			node = next_node
		end
		return node.is_leaf 
	end

end
root = TrieNode.new
trie = Trie.new(root)
trie.insert('aditya')
trie.insert('anuj')
trie.insert('the')
trie.insert('their')
p trie.search('aditya')
p trie.search('anuj')
p trie.search('the')
p trie.search('their')
p trie.search('adi')


