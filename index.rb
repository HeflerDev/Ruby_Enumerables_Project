module Enumerable
def my_each
  if block_given?
    index = 0 
    while index < length
      yield(self[index])
      index += 1
    end
  else
    to_enum(:my_each)
  end
end

def my_each_with_index
  if block_given?
    index = 0 
    while index < length
      yield(self[index], index)
      index += 1
    end
  else
    to_enum(:my_each_with_index)
  end
end

def my_select 
  array = []
  if block_given?
    #aplica my_each para cada elemento, se yield(x) retornar verdadeiro, array.push()
      self.my_each {|x| array.push(x) if yield(x) }
    array
  else
    to_enum(:my_select)
  end
end

def my_all?
  if block_given?
    self.my_each{|x| return false unless yield(x)}
    true
  else
    to_enum(:my_all)
  end
end

def my_any?
  if block_given?
    self.my_each{|x| return true if yield(x)}
    false
  else
    to_enum(:my_any?)
  end
end

def my_none?
  if block_given?
    self.my_each{|x| return false if yield(x)}
    true
  else
    to_enum(:my_none?)
  end
end

def my_count 
  if block_given?
    counter = 0
    self.my_each{|x| counter += 1 if yield(x)}
    counter
  else
    to_enum(:my_count)
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
  else
    to_enum(:my_map)
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