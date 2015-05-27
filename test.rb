# class Test
#     def aditya
#         puts "aditya"        
#     end
# end
# o = Test.new
# o.aditya

# def o.aditya1
#     puts "singleton method"
# end
# o.aditya1

# class Test
#     def aditya2
#         puts "add new method to test class"
#     end
# end
# o.aditya2

# s = String.new("hello")
# s1 = String.new("hello1")
# puts s
# puts s1
# def s.singleton_method_on_string_class
#     puts "verified"
# end
# puts s.singleton_method_on_string_class
# # puts s1.singleton_method_on_string_class DOES'T WORK BCOZ SINGLETON METHODIS DEFINED ONLY ON s OBJECT NOT ON s1
# s.instance_eval do 
#     def instance_eval_method
#         puts "working!"
#     end
# end
# s.instance_eval_method
# # s1.instance_eval_method       DOES'T WORK

# String.instance_eval do
#     def this_is_class_method
#         puts "this_is_class_method"
#     end
# end
# # String.this_is_class_method    DOES not WORK, bcoz it is a class method 

# String.this_is_class_method

# # s.really_it_works       Does not work 

# String.class_eval do
#     def this_is_an_instance_or_object_method
#         puts "this_is_an_instance_or_object_method"
#     end
# end

# s.this_is_an_instance_or_object_method
# s1.this_is_an_instance_or_object_method

# #String.this_is_an_instance_or_object_method    Does not work bcoz its instance method


# class MailTruck
#     attr_accessor :driver, :route
#     @@class_var = 1
#     def initialize(driver, route)
#         @driver, @route = driver, route
#     end
# end

# m = MailTruck.new("a", ["b", "c"])
# puts m.inspect
# m.instance_variable_set("@speed", 45)
# puts m.inspect

# m1 = MailTruck.new("a1", ["b1", "c1"])
# puts m1.inspect

# #puts m.class_var

# class Aditya
#     private
#     def m
#         puts "inside class aditya method m"
#     end
#     def p
#         puts "inside class aditya method p"
#     end
#     protected
#     def n
#         puts "inside class aditya method n"
#     end
# end

# o = Aditya.new
# o.send :m
# # o.m  DOES'T WORK 

# # o.n DOES'T WORK
# # o.send :n DOES'T WORK

# class Child < Aditya
#     def m
#         puts p
#         puts n
#         #super 
#         puts "overide method m of Aditya"
#     end
# end

# o = Child.new
# puts o.m
# #puts o.n 

# class Err 
#     def cal(b)
#         a = 1/b
#     rescue Exception => e
#         puts e
#         puts e.class
#         puts "hello"
#     end
# end

# e = Err.new
# e.cal(2)

module Adityam
    def module_instance_method
        puts "moule instance method"        
    end
    
    def Adityam.module_method
        puts "module method"
    end
end

class Klass
    include Adityam
    include Adityam
    def class_instace_method
        puts "class instance method"        
    end

    def test_module_method
        Adityam.module_method  
        module_instance_method
    end
end

obj = Klass.new
#Klass.module_instance_method
obj.class_instace_method
#obj.module_instance_method
obj.test_module_method

# class Parent
#   #private
#   protected
#   def name
#     'Mommy'
#   end
# end

# class Child < Parent
#   def get_parent_name
#     # Implicit receiver
#     puts name

#     # Explicit receiver
#     puts self.name rescue puts 'NoMethodError'

#     # Explicit receiver
#     puts Parent.new.name rescue puts 'NoMethodError'
#   end
# end

# Child.new.get_parent_name