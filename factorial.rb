class Factorial
	def multiply_strings(str1, str2)
		result = Array.new
		i = 0
		str2.each_char do |s|
			carry = 0
			j = 0
			str1.each_char do |s1|
				temp = s.to_i * s1.to_i + carry + result[i+j].to_i
				carry = temp/10
				val = temp%10
				result[i+j] = val.to_s
				j += 1
			end
			i += 1
			result << carry if carry > 0
		end
		result.reverse.join
	end

	def factorial(n)
		return 1 if n <= 1
		return multiply_strings(n.to_s.reverse, factorial(n-1).to_s.reverse)
	end
end
p Factorial.new.factorial(500)
