# Dynamic dispatch - To pass message to private methods
p '########################## Dynamic dispatch ###################################'
dynamic_dispatch = 1.send(:+, 2)

p dynamic_dispatch

# Dynamic method - To define dynamic method
p '########################## Dynamic method ####################################'
class Car
  def self.features(*args)
    args.each do |feature|
      define_method "#{feature}=" do |info|
        instance_variable_set("@#{feature}", info)
      end

      define_method "#{feature}" do |info|
        instance_variable_get("@#{feature}", info)
      end
    end
  end

  features :engine_info, :engine_price, :wheel_info, :wheel_price, :airbag_info, :airbag_price, :alarm_info, :alarm_price
end

car = Car.new
car.engine_info = 'Made in China'
car.engine_price = '12$'
car.wheel_info = 'Tvs Tyres'
car.wheel_price = '15$'
car.airbag_info = 'Made in Australia'
car.airbag_price = '20$'
car.alarm_info = 'Made in japan'
car.alarm_price = '30$'
p car

# Ghost methods
p '########################## Ghost methods #######################################'
class Foo
  def method_missing(method, *args, &block)
    p "you called #{method} #{args.join(' ')}"
    p "You are passing block #{block}" if block_given?
  end
end

Foo.new.yolo
Foo.new.yolo 'a', 123, :c
Foo.new.yolo(:a, :b, :c) { p 'a block' }

# Blank slate
p '########################## Blank Slate ########################################'
class ImBlank
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^__|method_missing|respond_to?|object_id/
  end

  # rest of your code (such as your "Dynamic Proxy" implementation)
end

p ImBlank.instance_methods

# Hook methods
p '########################## Hook Methods ########################################'
class String
  def self.inherited(subClass)
    p "#{self} was inherited by #{subClass}"
  end
end

class MyString < String; end;

# Class & Module Hooks
=begin
inherited
append_features
included
extend_object
extended
initialize_copy
const_missing
=end

# class inherited Mixin
p '########################## Inheritance Mixin ###################################'
module MyUser
  def self.included(base)
    base.extend(ClassMethods)
  end

  def a
    puts "I'm A - instance method"
  end

  module ClassMethods
    def x
      puts "I'm X - class method"
    end
  end
end

class Foo
  include MyUser
end

Foo.new.a
Foo.x






