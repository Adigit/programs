class Test
    def initialize(a)
    end

    def dest
        a = [12, 5, -3, 8, 3, 6]
        #(x,y) => x-y Maximized
        #o/p-> Max. difference

        #condition => indexOf(x) > indexOf(y)
        max = nil # just initialize
        i =  a.size
        j = i-1
        while i >= 0
            while j >= 0
                temp = a[i] - a[j]
                if max.nil?
                    max = temp
                elsif temp > max
                    max = temp
                end
                j = j -1 
            end
            i = i -1
        end
        puts max
    end
end


a = [12, 5, -3, 8, 3, 6]
o = Test.new(a)
o.dest