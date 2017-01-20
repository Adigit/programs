class LongestPalindromicSubsequence
	def initialize(str)
		@str = str
	end
	
	def lps
		ptr1 = 0
		ptr2 = 1
		_start = 0
		_end = 0
		s = @str.size
		for i in 0..(s-1)
			puts "s > #{_start} > e > #{_end} > ptr1 > #{ptr1} > ptr2 > #{ptr2}"
			
			if (@str[ptr1] == @str[ptr2]) || (@str[ptr1] == @str[ptr2+1])
				if (_end - _start) <= (ptr2 - ptr1) && (@str[ptr1] == @str[ptr2])
					_start = ptr1
					_end = ptr2 	
				elsif (@str[ptr1] == @str[ptr2+1]) && ((_end - _start) <= (ptr2 + 1 - ptr1))
					_start = ptr1
					_end = ptr2 + 1
				end
				puts @str[_start.._end]
				if (ptr1 != 0 && ptr2 != (s -1) && @str[ptr1 - 1] == @str[ptr2 + 1])
					if (@str[ptr1] == @str[ptr2])
						ptr2 = ptr2
					elsif (@str[ptr1] == @str[ptr2 +1])
						ptr2 = ptr2 + 1
					end
					ptr1 = ptr1 - 1
					ptr2 = ptr2 + 1
				else
					ptr1 = ptr1 + 1
					ptr2 = ptr1 + 1	
				end
			else
				ptr1 = ptr1 + 1
				ptr2 = ptr1 + 1
			end
		end
		puts @str[_start.._end]
	end
	
end

puts "Enter String"
str = gets.chomp
obj = LongestPalindromicSubsequence.new str
obj.lps