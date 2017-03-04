class NumberToString
  def initialize(number)
    @number = number
    @length = number.length
  end

  def convert
    digits = [[ "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"],
                     ["", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"],
                     ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"],
                     ["hundred", "thousand"]]
 
    two_digits = ["", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
 
    tens_multiple = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
 
    tens_power = ["hundred", "thousand"]

    i = @length - 1

    str = ""
    while (@length - i) >= 0
      index = if i == 3 
          1
        elsif i == 2
          0
        else
          i
        end
      str += @number[i] + digits[i][index] if @number[i] != 0
      i = i - 1
    end
    str
  end
end

obj = NumberToString.new('6457')
obj.convert