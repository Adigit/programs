class ArrayRotation
	def imitialize(arr, k)
		@arr = arr
		@k = k
	end

	def rotate
		i = 0
		n = gcd(@arr.size, @k)
		while i < n
			
		end
	end

	private

	def gcd(a, b)
		if b == 0
			a
		else
			gcd(b, a%b)
		end
	end
end