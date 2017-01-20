class PrintString
	
	def initialize(str)
		@str = str
	end
	
	def print_string
		buffer = []
		buffer << @str[0]
		recursive_print(buffer, 1, @str.size)
	end

	def recursive_print(buffer, i, size)
		if i == size
			print buffer.join(',')
			puts "\n"
			return
		end
		temp = buffer.clone
		buffer << @str[i]
		recursive_print(buffer, i+1, size)
		
		buffer = temp.clone
		buffer << " "
		buffer << @str[i]
		recursive_print(buffer, i+1, size)		
	end	
end

puts "Enter string"
str = gets.chomp
o = PrintString.new str
o.print_string