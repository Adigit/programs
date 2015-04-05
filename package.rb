class Package
	@@hotel_per_night_cost_hash = {} 
	@@package_cache = {}
	@@month_days = {1 => 31, 2 => 29, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
	MAX_PACKAGE_NIGHTS = 15
	
	def initialize
		# hotel_per_night_cost_hash is a hash which contains hotel per night price
		# key format is date/month, for example 1 January price is 600 rupee and 22 November price is 700
		# then hash will be
		# hotel_per_night_cost_hash['1/1'] = 600 for 1st jan 
		# hotel_per_night_cost_hash['22/11'] = 700 for 22th nov
		@@hotel_per_night_cost_hash = {}
		month = 1
		while month <=12
			# Initializing hotel_per_night_cost_hash
			prepare_hash(@@month_days[month], month)
			month += 1
		end
		#puts @@hotel_per_night_cost_hash
		# preparing package price hash
		prepare_cache_type_struct
	end
	
	# Populating hotel_per_night_cost_hash 
	def prepare_hash(days, month)
		day = 1
		while day <= days
			key = "#{day}/#{month}"
			@@hotel_per_night_cost_hash[key] = rand(500..1000) # Assuming that hotel prices is between 500 and 1000
			day += 1
		end
	end

	# Populating @@package_hash per month
	def monthly(days, month)
		date = 1
		while date <= days 
			key = ""
			package_night = 1
			previous_key = ""
			while package_night <= MAX_PACKAGE_NIGHTS
				key = "#{month}/#{date}/#{package_night}"
				if (date + package_night - 1) <= days 
					next_date = date + package_night - 1
					@@package_cache[key] = @@hotel_per_night_cost_hash["#{next_date}/#{month}"] + @@package_cache["#{previous_key}"].to_i
				else 
					next_month_date =  (date + package_night - 1)%days
					if month == 12
						next_month = 1 
					else
						next_month = month + 1
					end
					@@package_cache[key] = @@hotel_per_night_cost_hash["#{next_month_date}/#{next_month}"] + @@package_cache["#{previous_key}"].to_i
				end	
				previous_key = key
				package_night += 1			
			end
			date += 1
		end
	end

	# This method is creating hash type structure for all types of packages, in real life situation we can save it in Memcache
	def prepare_cache_type_struct
		month = 1
		while month <= 12
			monthly(@@month_days[month], month)
			month += 1
		end
		#puts ">>>> @package_cache >>> #{@package_cache}"
	end

	def change_hotel_price_per_night
		input = ""
		puts "Plz inter date and price"
		until input == 'done'
			m = ""
			until m.to_i != 0 && m >= 1 && m <= 12
				puts 'Enter month'
				m = gets.chomp.to_i
			end
			d = "" 
			until d.to_i != 0 && !@@month_days[m].nil? && d >= 1 && d <= @@month_days[m] #((([1,3,5,7,8,10,12].include? m) && d >= 1 && d <= 31) || (m == 2 && d >= 1 && d <= 29) || (([4,6,9,11].include? m) && d >= 1 && d <= 30))
				puts 'Enter date'
				d = gets.chomp.to_i
			end
			p = ""
			until p.to_i != 0
				puts "Enter price"
				p = gets.chomp.to_i
			end
			change_in_price = -(@@hotel_per_night_cost_hash["#{d}/#{m}"] - p)
			if d >= 15
				start_date = d - MAX_PACKAGE_NIGHTS + 1
				get_all_packages_and_modify_them(start_date, m, change_in_price)			
			else
				if m == 1
					last_month = 12 
				else
					last_month = m - 1
				end
				start_date = @@month_days[last_month] - (MAX_PACKAGE_NIGHTS - d) + 1
				get_all_packages_and_modify_them(start_date, last_month, change_in_price)
			end
			@@hotel_per_night_cost_hash["#{d}/#{m}"] = p
			puts "Enter done if u r done else continue.."
			input = gets.chomp
		end
		#puts ">>>>> @package_cache >>>> #{@package_cache}"
	end

	def get_all_packages_and_modify_them(date, month, price_change)
		i = 1
		while i <= MAX_PACKAGE_NIGHTS
			j = i
			while j >= 1
				nights = MAX_PACKAGE_NIGHTS - j + 1
				key = "#{month}/#{date}/#{nights}"
			    initial_price = @@package_cache[key]
				@@package_cache[key] += price_change
				puts " >> month >> #{month} >> start date >> #{date} >> package nights >> #{nights} >> initial price >> #{initial_price} >> after change >> #{@@package_cache[key]}"
				j -= 1
			end			
			i += 1
			date += 1
			if date > @@month_days[month]
				date = 1
				month = (month + 1)%12
			end
		end
	end
	Array.new(10) { |i|  }

	def get_configurations(date, month, change_hash)
		i = 1
		while i <= MAX_PACKAGE_NIGHTS
			j = i
			while j >= 1
				nights = MAX_PACKAGE_NIGHTS - j + 1
				if change_hash["#{date}/#{month}"].nil?
					change_hash["#{date}/#{month}"] = [nights]
				elsif !change_hash["#{date}/#{month}"].include? nights
					change_hash["#{date}/#{month}"] << nights
				end
				j -= 1
			end			
			i += 1
			date += 1
			if date > @@month_days[month]
				date = 1
				month = (month + 1)%12
			end
		end
	end

	def number_of_configuration_change
		change_hash = {}
		input = ""
		until input == 'done'
			m = ""
			until m.to_i != 0 && m >= 1 && m <= 12
				puts 'Enter month'
				m = gets.chomp.to_i
			end
			d = "" 
			until d.to_i != 0 && !@@month_days[m].nil? && d >= 1 && d <= @@month_days[m] 
				puts 'Enter date'
				d = gets.chomp.to_i
			end	
			puts "Enter done if u r done else continue.. "
			input = gets.chomp
			if d >= 15
				start_date = d - MAX_PACKAGE_NIGHTS + 1
				get_configurations(start_date, m, change_hash)			
			else
				if m == 1
					last_month = 12 
				else
					last_month = m - 1
				end
				start_date = @@month_days[last_month] - (MAX_PACKAGE_NIGHTS - d) + 1
				get_configurations(start_date, last_month, change_hash)
			end
		end
		size = 0
		total_number_of_configuration_change = change_hash.each{|h,k| size += k.size}
		puts size
		puts total_number_of_configuration_change
	end
end

obj = Package.new
#obj.change_hotel_price_per_night
obj.number_of_configuration_change

