module Enumerable
  def my_each
    if block_given?
      index = 0 ;
      while index < length
        yield(self[i])
        index += 1
      end
  end
end


def my_each_with_index
  if block_given?
    index = 0 ;
    while index < length
      yield(self[index], index)
      index += 1
    end
  end
end




=begin 
def my_each
    if block_given?
      i = 0
      while i < length
        yield(self[i])
        i += 1
      end
    else
      to_enum(:my_each)
    end
  end
=end
