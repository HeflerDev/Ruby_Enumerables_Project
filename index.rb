module Enumerable
  def my_each
    if block_given?
      index = 0 ;
      while index < length
        yield(self[index])
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

def my_select 
  array = []
  if block_given?
    #aplica my_each para cada elemento, se yield(x) retornar verdadeiro, array.push()
      self.my_each {|x| array.push(x) if yield(x) }
    array
  end
end

def my_all?

end