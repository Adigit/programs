class LongestPalindromicSubsequence
	def initialize(str)
		@str = str
		@dp_arr = Array.new(str.size) { Array.new(str.size)  }
	end
	
	def lps(i, j)
		if i > j
			return 0 
		elsif i == j
			return 1
		else
			print ">> i >> #{i} >> j  >> #{j}\n"
			if @str[i] == @str[j]
				return lps(i+1, j-1) + 2 
			elsif @dp_arr[i][j] 
				return @dp_arr[i][j]
			else
				@dp_arr[i][j] = [lps(i, j-1), lps(i+1, j)].max
			end
		end
	end
	
	def print_dp_arr
		@dp_arr.each do |arr|
			print ">>> #{arr}\n"
		end		
	end
end
obj = LongestPalindromicSubsequence.new("BBABCBCAB")
op = obj.lps(0,8)
obj.print_dp_arr
print ">> op >> #{op}\n"


