ANIMAL = 'Tiger'

module Foo
  ANIMAL = 'Lion'
  class Bar
    def value1
      print ANIMAL + "\n"
    end
  end
end

class Foo::Bar
  def value2
    print ANIMAL + "\n"
  end
end


Foo::Bar.new.value1

Foo::Bar.new.value2

