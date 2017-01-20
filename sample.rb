h = {"s1"=>10, "s2"=>12, "s3"=>15, "s4"=>25, "s5"=>35, "s6"=>45, "s7"=>60}
t1 = Hash.new(0)
time_array = h.values 
time_array.each_with_index do |v, index|
	temp = {}
	s = 180
	time_array[index...time_array.size].each do |v|
		if s > v
			temp['9-12'] = temp['9-12'].to_i + 1
			s = s - v
				p " 0 >>>>#{temp['9-12']} >>>> s >>>> #{s} >>>> index >>> #{index} >>>> v >>>>> #{v}"
		end
	end
	p " 1 >>>>#{temp['9-12']}"
	time_array[0...index].each do |v|
		if s > v
			temp['9-12'] = temp['9-12'].to_i + 1
			s = s - v
		end
	end
	p " 2 >>>>#{temp['9-12']}"
	p " 3 >>>>#{t1['9-12']}"
	t1['9-12'] = temp['9-12'] if t1['9-12'] < temp['9-12']
	temp['9-12'] = 0
end