module Enumerable
def my_each
  if block_given?
    index = 0 
    while index < length
      yield(self[index])
      index += 1
    end
  end
end

def my_each_with_index
  if block_given?
    index = 0 
    while index < length
      yield(self[index], index)
      index += 1
    end
  end
end

def my_select 
  array = []
  if block_given?
    #aplica my_each para cada elemento, se yield(x) retornar verdadeiro, array.push()
      self.my_each {|x| array.push(x) if yield(x) }
    array
  end
end

def my_all?
  if block_given?
    self.my_each{|x| return false unless yield(x)}
    true
  end
end

def my_any?
  if block_given?
    self.my_each{|x| return true if yield(x)}
    false
  end
end

def my_none?
  if block_given?
    self.my_each{|x| return false if yield(x)}
    true
  end
end

def my_count 
  if block_given?
    counter = 0
    self.my_each{|x| counter += 1 if yield(x)}
    counter
  end
end

def my_map
  if block_given?
    array = []
    self.my_each{|x| array.push(yield(x))}
    array
  elsif proc
    array = []
    self.my_each{ |x| array.push(proc.call(x))}
    array
  else
    to_enum(:my_map)
  end
end


def my_inject
  if block_given?
    prod ||= 0
    self.my_each{|x| prod = yield(prod, x)}
    prod
  end
end

def multiply_els(arr)
  arr.my_inject{|product,result| product * result}
end


=begin 
def multiply_els(a)
  arr.my_inject{|x,y| x * y}
end

puts multiply_els([1,2,3])
=end
end