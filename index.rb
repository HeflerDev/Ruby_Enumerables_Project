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

def my_all?(exp = nil)
  if block_given?
    self.my_each{|x| return false unless yield(x)}
    true
  elsif exp
    if exp.is_a? Regexp
      self.my_each { |x| return false unless x =~ exp}
    elsif exp.is_a? Class
      self.my_each { |x| return false unless x.is_a? exp}
    else
      self.my_each { |x| return false unless x == exp}
    end
  else
    self.my_each { |x| return false unless x }
  end
  true
end

def my_any?(exp = nil)
  if block_given?
    self.my_each{|x| return true if yield(x)}
    false
  elsif exp
    if exp.is_a? Regexp
      self.my_each { |x| return true if x =~ exp}
    elsif exp.is_a? Class
      self.my_each { |x| return true if x.is_a? exp}
    else
      self.my_each { |x| return true if x == exp}
    end
  else
    self.my_each { |x| return true if x }
  end
  false
end

def my_none?(exp = nil)
  if block_given?
    self.my_each{|x| return false if yield(x)}
    true
  elsif exp
    if exp.is_a? Regexp
      self.my_each { |x| return false if x =~ exp }
    elsif exp.is_a? Class
      self.my_each { |x| return false if x.is_a? exp }
    else
      self.my_each { |x| return false if x == exp }
    end
  else
    self.my_each { |x| return false if exp}
  end
  true
end

def my_count 
  counter = 0
  if block_given?
    self.my_each{|x| counter += 1 if yield(x)}
    counter
  else
    self.my_each{ |x| counter += 1}
  end
end

def my_map(proc = nil)
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


def my_inject(i = nil, symb = nil)
  if block_given?
    prod ||= 0
    self.my_each{|x| prod = yield(prod, x)}
    prod
  elsif (i.is_a? Symbol) || (symb.is_a? Symbol)
    if cont.is_a? Symbol
      case cont
      when :+
        counter = 0
        my_each { |x| counter += x }
      when :-
        counter = self[0]
        self[1..-1].my_each { |x| counter -= x }
      when :*
        counter = self[0]
        self[1..-1].my_each { |x| counter *= x }
      when :/
        counter = self[0]
        self[1..-1].my_each { |x| counter /= x }
      end
      counter
    elsif i.is_a? Numeric
      case symb
      when :+
        my_each { |x| i += x }
      when :-
        my_each { |x| i -= x }
      when :*
        my_each { |x| i *= x }
      when :/
        my_each { |x| i /= x }
      end
      i
    else
      "undefined method for #{cont}:#{cont.class}"
    end
  else
    'no block given (LocalJumpError)'
  end
end

def multiply_els(arr)
  arr.my_inject(1){|product,result| product * result}
end
end