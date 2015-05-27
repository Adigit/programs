#QUESTION
#######################################################################################################

# We store prices of hotels on a per day basis, as in price of a hotel on 10th Jun is say Rs 1000, 
# and on 11th Jun is Rs 1400, say. 
# Now, if a person wants to book the hotel for two nights starting 10th Jun, 
# we are going to charge him Rs 2400 ( 1000 + 1400 ).. 

# Suppose we have each day from 1st of jan to 31st Dec  ( for a hotel ) mapped to a price
# 1st Jan - > Rs ...
# 2nd Jan  -> Rs ...
# ..
# 30 Dec -> Rs...
# 31st Dec -> Rs ...

# Also, we don't let a person book more than 15 nights in a single booking... 
# This means if a person wishes to book from 1st Mar to 16 Mar, we allow, 
#so do we 1st Mar to 10th Mar, but 1st Mar to 17 Mar is not allowed, 
#and so isn't 1st Mar to 28th Mar ( Stay length more than 15 nights )..

# Using what we described above, we need to::

# 1. 
# Create a cache type structure which has all the allowed configurations as the keys 
# and the respective prices as the value. 
# Say stay of 6 days from 1st Aug to 7th Aug as the key and  total price for the stay 
# ( 1st Aug Price + 2nd Aug Price + ... + 7th Aug price) as the value.. 
# So for a particular checkin day, we can have 15 different configurations, 
# 1 night stay, 2 nights' stay, ..., 15 nights' stay..

# 2. 
# Take as input the days whose prices change with the corresponding new values 
# and list all the configurations that change with those price changes.
 
# Suppose we change the price of some day, say 10th Jun, we need to list all the configurations that change.. 
# Also, if we change more than one day's price, say 10th Jun's and 15th Jun's, 
# we need to list all the configurations that change.. 

# 3. Mathematical modeling, as in a formula, or an approach which gives the number of configuration changes 
# with say n days' price change..

#ANSWER
##########################################################################################

class Package
	@@hotel_per_night_cost_hash = {} 
	@@package_cache = {}
	# ASUMING THAT GIVEN YEAR IS A LEAP YEAR FEB 29 DAYS, WITH SOME MINUTE CHANGES WE CAN EASILY HANDLE 
	# NON LEAP YEAR CASE ALSO, DUE TO LACK OF TIME NOT HANDLING NOW

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
	end

	def change_hotel_price_per_night
		puts "FUNCTION TO CHANGE NIGHT CHARGES OF HOTEL "
		puts "ENTER MONTH AND DATE YOU WANT TO CHANGE PRICE"
		puts "ENTER MONTH IN NUMERIC VALUES FOR EXAMPLE 1 FOR JANUARY AND 3 FOR MARCH"
		puts "ENTER DATE IN NUMERIC FROM 1 TO LAST DATE OF MONTH (BASED ON THE MONTH)"
		puts "LAST DATE OF JANUARY IS 31 AND LAST DATE OF APRIL IS 30"
		puts "IF KEEP ASKING YOU UNTIL YOU GIVE CORRECT DATA"
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
				puts "Enter new price"
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
			puts "Enter done if u r done else hit enter key"
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
				puts " >> month >> #{month} >> start date >> #{date} >> package nights >> #{nights} >> initial price >> #{initial_price} >> >> after change >> #{@@package_cache[key]}"
				j -= 1
			end			
			i += 1
			date += 1
			if date > @@month_days[month]
				date = 1
	#			month = (month + 1)%12
				if month == 12
					month = 1 
				else
					month += 1
				end
			end
		end
	end
	
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
		puts "FUNCTION TO GET ALL NUMBER OF CONFIGURATION CHANGES BASED ON HOTEL NIGHT PRICE CHANGE"
		puts "ENTER MONTH AND DATE YOU WANT TO CHANGE PRICE"
		puts "ENTER MONTH IN NUMERIC VALUES FOR EXAMPLE 1 FOR JANUARY AND 3 FOR MARCH"
		puts "ENTER DATE IN NUMERIC FROM 1 TO LAST DATE OF MONTH (BASED ON THE MONTH)"
		puts "LAST DATE OF JANUARY IS 31 AND LAST DATE OF APRIL IS 30"
		puts "IF KEEP ASKING YOU UNTIL YOU GIVE CORRECT DATA"
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
			puts "Enter done if u r done else hit enter key "
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
		total_number_of_configuration_change = 0
		change_hash.each{|h,k| total_number_of_configuration_change += k.size}
		puts "TOTAL NUMBER OF CONFIGURATION CHANGES ARE #{total_number_of_configuration_change}"
		#puts change_hash
	end
end

# AT THE TIME OF INITIALIZE WE ARE SEEDING HOTEL PRICE (ASUMING THAT HOTEL PRICE IS BETWEEN 500 AND 1000)
# THROUGH RANDOM GENERATOR
# AND ALSO CREATING CONFIGURATION CAHCHE STRUCTURE

obj = Package.new

obj.change_hotel_price_per_night

# TOTAL NUMBER OF CONFIGURATION CHANGE DEPENDS ON DATES, FOR EXAMPLE WE INPUT 3 DATES SAY 1ST JANUARY,
# 15 JUNE AND 21 AUG THEN TOTAL NUMBER OF CONFIGURATION CHANGE WILL BE SUM OF 
# CONFIG_CHANGE(1ST JANUARY) + CONFIG_CHANGE(15 JUNE) + CONFIG_CHANGE(21 AUG)

# BUT IF TWO DATES ARE, SAY 21 AUG AND 27 AUG THEN THERE WILL SOME INTERSECTION WHICH IS COMMON BETWEEN BOTH
# SO IN THIS CASE IT WILL BE  CONFIG_CHANGE(21 AUG) + CONFIG_CHANGE(21 AUG) - INTERSECTION_CONFIG
obj.number_of_configuration_change

