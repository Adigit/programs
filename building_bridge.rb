class City
	attr_accessor :city_number, :pointing_loc
	def initialize(num)
		@city_number = num
		@pointing_loc = -1
	end
end

class BuildingBridge
	def initialize(northern_cities, southern_cities)
		@nc = northern_cities
		@sc = southern_cities
		@dp_arr = Array.new(@nc.size) {1}
	end
	
	def max_bridges
		@nc.each do |nc|
			nc.pointing_loc = search_city_in_southern_cities(nc)			
		end
		index = 1
		@nc[1..@nc.size].each do |nc|
			i = 0
			@nc[0..(index-1)].each do |n|
				if (nc.pointing_loc > n.pointing_loc) && (@dp_arr[index] <= @dp_arr[i])
					@dp_arr[index] =  @dp_arr[i] + 1
				end
				i += 1
			end
			index += 1
		end

		return @dp_arr.max

	end

	# Running time O(n) 
	def search_city_in_southern_cities(city)
		@sc.index(city.city_number)
	end
end
northern_cities = [1,2,3,4,5,6,7,8]
northern_cities =  northern_cities.map {|x| City.new(x)}
southern_cities = [8,1,4,3,5,2,6,7]
obj = BuildingBridge.new(northern_cities, southern_cities)
print "Max number of non crossing bridges >> #{obj.max_bridges}\n"
