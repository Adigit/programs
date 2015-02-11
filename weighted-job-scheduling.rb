class Job
	attr_accessor :start, :end, :weight, :job
	
	def initialize(args = {})
		@start = args['start']
		@end = args['end']
		@weight = args['weight']
		@job = args
	end

	def start
		@start
	end

	def end
		@end
	end

	def weight
		@weight
	end

	def job
		@job
	end
end

class JobArray
	attr_accessor :jobs	
	
	def initialize()
  		super 
   		@jobs = []
	end

	def add_jobs(j)
		@jobs << j
	end

	def get_all_jobs
		@jobs
	end

end

class WeightedJobScheduling
	def initialize(args)
	end
	
	def sort_based_end_time(jobs)
		puts jobs	
		#suppose we hv used merge sort to sort these jobs based on their end time, but for now already takeing in sorted order	
		j1 = {"start" => 3, "end"=> 10, "weight"=>20}
		j2 = {"start" =>1, "end"=> 2, "weight" => 50}
		j3 = {"start" => 6, "end" => 19, "weight" => 100}
		j4 = {"start" => 2, "end" => 100, "weight" =>200}	
		jobs.add_jobs(j2)
		jobs.add_jobs(j1)
		jobs.add_jobs(j3)
		jobs.add_jobs(j4)
		return jobs
	end
end

job_arr = JobArray.new
j1 = {"start" => 3, "end"=> 10, "weight"=>20}
j2 = {"start" =>1, "end"=> 2, "weight" => 50}
j3 = {"start" => 6, "end" => 19, "weight" => 100}
j4 = {"start" => 2, "end" => 100, "weight" =>200}
job_arr.add_jobs(j1)
job_arr.add_jobs(j2)
job_arr.add_jobs(j3)
job_arr.add_jobs(j4)

obj = WeightedJobScheduling.new
jobs = obj.sort_based_end_time(job_arr)


=begin
loop do 
	puts "Enter jobs >> "
	j = gets.chomp
	break if j == "end" 
	job = Job.new(j)
	puts job.job.to_hash
	job_arr.add_jobs(job)
end
puts job_arr.get_all_jobs.first
=end
