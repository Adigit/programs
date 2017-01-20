class LongestEvenLengthSubstringSumFirstSecondHalf
	attr_accessor :str
	
	def initialize(str)
		@str = str
	end
	
	def get_result
		arr = Array.new(str.size) { Array.new(str.size) }
		i = 0
		str.each_char do |c|
			arr[i][i] = c.to_i
			i += 1
		end	
		arr.each do |a|
			print "\n >>>> arr >>> #{a}\n"
		end
		s = -1
		e = -1
		(0..(str.size - 1)).each do |i|
			((i+1)..(str.size - 1)).each do |j|
				arr[i][j] = arr[i][j-1].to_i + arr[j][j].to_i
				if i.odd? && arr[i][j].even? && arr[i][j/2] == arr[i][j]/2
					s = j/2
					e = j
					print ">> s >> #{s} >> e >> #{e}\n"
				end
			end
		end
		arr.each do |a|
			print "\n >>>> arr >>> #{a}\n"
		end
		
	end
end

obj = LongestEvenLengthSubstringSumFirstSecondHalf.new("1538044")
obj.get_result
