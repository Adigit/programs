class Node
	attr_accessor :val, :move
	def initialize(val, move)
		@val = val
		@move = move
	end
	
	def val
		@val
	end
	
	def move
		@move
	end
end

class LongestCommonSubsequence
	def initialize(str1, str2)
		@str1 = str1
		@str2 = str2
		@dp_arr = Array.new(str1.size + 1) { Array.new(str2.size + 1) }
		i = 0
		node =  Node.new(0, [])
		while i <= str1.size do
			@dp_arr[i][0] = node
			i += 1
		end
		i = 0
		while i <= str2.size do
			@dp_arr[0][i] = node
			i += 1
		end
		#print @dp_arr
	end
	
	def lcs
		i = 1
		while i <= @str1.size do 
			a = @str1[i-1]
			j = 1
			while j <= @str2.size do
				b = @str2[j-1]
#				puts ">> a >> #{a} >> b >> #{b} >> i >> #{i} >> j >> #{j}"
				if a == b
					v = @dp_arr[i-1][j-1].val + 1
					move = [i-1, j-1, true]
				elsif @dp_arr[i-1][j].val > @dp_arr[i][j-1].val
					v = @dp_arr[i-1][j].val
					move = [i-1, j, false]
				else
					v = @dp_arr[i][j-1].val
					move = [i, j-1, false]
				end
				node = Node.new(v, move)
				@dp_arr[i][j] = node
				j += 1
			end
			#	print @dp_arr		
			i = i + 1
		end
	end

	def print_dp_arr
		@dp_arr.each do |arr|
			arr.each do |a|
				print "#{a.val}  #{a.move}  "
			end
			print "\n"
		end
		print "\n"
	end

	def print_lcs
		i = @str1.size
		j = @str2.size
		len = 0
		while i > 0 && j > 0  do
			node = @dp_arr[i][j] 
			flag = node.move[2]
			if flag
				print @str1[i-1]
				len += 1
			end
			i = node.move[0]
			j = node.move[1]
		end
		print "\n"
		print ">> length >> #{len}\n"
	end
end
obj = LongestCommonSubsequence.new("AGGTAB", "GXTXAYB")
obj.lcs
obj.print_dp_arr
obj.print_lcs