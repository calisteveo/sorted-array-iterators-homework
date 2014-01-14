class SortedArray
  attr_accessor :internal_arr # This is for convenience in the tests.

  def initialize(input_arr=[])
    @internal_arr = []
    input_arr.each {|x| add(x)}
    # Fill in the rest of the initialize method here.
    # What should you do with each element of the incoming array?
  end

  def add(new_ele)
    @internal_arr.insert(new_ele)
    # Hint: Use the Array#insert method.
    #raise NotImplementedError.new("You need to implement the add method!")
  end

  def size
    @internal_arr.size
  end

  def [](index)
    return @internal_arr[index]
    #raise NotImplementedError.new("You need to implement the [] method!")
  end

  def first_larger_index(target, start_ind=0, end_ind=@internal_arr.size)
    if start_ind >= end_ind
      return end_ind
    end

    mid_ind = ((end_ind + start_ind)/2)
        
    mid_elem = @internal_arr[mid_ind]
  
    if mid_elem == target
      return mid_ind
    elsif mid_elem > target
      return first_larger_index(target, start_ind, mid_ind)
    else mid_elem < target
      return first_larger_index(target, mid_ind + 1, end_ind)
    end
          
  end
    #raise NotImplementedError.new("You need to implement the first_larger_index method!")

  def index(target)
    @internal_arr.find_index(target)
    return
    #raise NotImplementedError.new("You need to implement the index method!")
  end
end