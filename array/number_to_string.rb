class NumberToString
  MAX_LENGTH = 3
  def initialize(number)
    @number = number
    @length = number.length - 1
  end

  def convert
    digits = [[ "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"],
                     ["", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"],
                     ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"],
                     ["hundred", "thousand"]]
 
    two_digits = ["", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
 
    tens_multiple = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
 
    tens_power = ["hundred", "thousand"]

    i = @length
    str = ""
    while  i >= 0
      j = MAX_LENGTH - i
      index = @length - i

      if @number[index].to_i != 0
        str = str + ' ' + if j == 0 
          digits[0][@number[index].to_i] + ' ' + digits[3][1]
          elsif j == 1
            digits[0][@number[index].to_i] + ' ' + digits[3][0]
          elsif j == 2 && @number[index].to_i >= 2
            digits[2][@number[index].to_i]
          elsif j == 2 && @number[index].to_i == 1 && @number[@length].to_i == 0
            i = i - 1
            'ten'
          elsif j == 2 && @number[index].to_i == 1
            i = i -1
            digits[1][@number[@length].to_i + 1]
          else
            digits[0][@number[index].to_i]
          end
      end
      i = i - 1
    end
    str
  end
end

obj = NumberToString.new('1202')
p obj.convert