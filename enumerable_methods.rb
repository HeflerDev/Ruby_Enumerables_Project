# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    if block_given?
      index = 0
      while index < length
        yield(self[index])
        index += 1
      end
      self
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
      my_each { |x| array.push(x) if yield(x) }
      array
    else
      to_enum(:my_select)
    end
  end
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_all?(exp = nil)
    if block_given?
      my_each { |x| return false unless yield(x) }
      true
    elsif exp
      if exp.is_a? Regexp
        my_each { |x| return false unless x =~ exp }
      elsif exp.is_a? Class
        my_each { |x| return false unless x.is_a? exp }
      else
        my_each { |x| return false unless x == exp }
      end
    else
      my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(exp = nil)
    if block_given?
      my_each { |x| return true if yield(x) }
      false
    elsif exp
      if exp.is_a? Regexp
        my_each { |x| return true if x =~ exp }
      elsif exp.is_a? Class
        my_each { |x| return true if x.is_a? exp }
      else
        my_each { |x| return true if x == exp }
      end
    else
      my_each { |x| return true if x }
    end
    false
  end

  def my_none?(exp = nil)
    if block_given?
      my_each { |x| return false if yield(x) }
      true
    elsif exp
      if exp.is_a? Regexp
        my_each { |x| return false if x =~ exp }
      elsif exp.is_a? Class
        my_each { |x| return false if x.is_a? exp }
      else
        my_each { |x| return false if x == exp }
      end
    else
      my_each { |x| return false if x }
    end
    true
  end

  def my_count(num = nil)
    counter = 0
    if block_given?
      my_each { |x| counter += 1 if yield(x) }
    else
      my_each do |x|
        counter += 1 if num == x
      end
    end
    counter
  end

  puts [1,2,2,3,4,5].my_count(2)

  def my_map(proc = nil)
    if block_given?
      array = []
      my_each { |x| array.push(yield(x)) }
      array
    elsif proc
      array = []
      my_each { |x| array.push(proc.call(x)) }
      array
    else
      to_enum(:my_map)
    end
  end

  # rubocop:disable Metrics/MethodLength
  def my_inject(ind = to_a[0], symb = nil)
    if block_given?
      ind ||= 0
      to_a.my_each { |x| ind = yield(ind, x) }
      ind
    elsif (ind.is_a? Symbol) || (symb.is_a? Symbol)
      if ind.is_a? Symbol
        case ind
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
      elsif ind.is_a? Numeric
        case symb
        when :+
          my_each { |x| ind += x }
        when :-
          my_each { |x| ind -= x }
        when :*
          my_each { |x| ind *= x }
        when :/
          my_each { |x| ind /= x }
        end
        ind
      else
        "undefined method for #{ind}:#{ind.class}"
      end
    else
      'no block given (LocalJumpError)'
    end
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, result| product * result }
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
