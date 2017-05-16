require "benchmark"

module Enumerable
  def my_each
    self.length.times {|i| yield(self[i])}
  end

  def my_each_with_index
    self.length.times {|i| yield(self[i], i)}
  end

  def my_select
    new_array = []
    self.length.times do |i|
      new_array.push(self[i]) if yield(self[i]) == true
    end
    return new_array
  end

  def my_all?
    self.length.times { |i| return false if yield(self[i]) == false }
    return true
  end

  def my_any?
    self.length.times { |i| return true if yield(self[i]) == true }
    return false
  end
  def my_none?
    self.length.times {|i| return false if yield(self[i]) == true }      
    return true
  end
  def my_none2?
    self.my_each { |x| return false if yield(x) == true}
    return true
  end
  def my_count(value=nil)
    count = 0
    if block_given?
      self.length.times {|i| count += 1 if yield(self[i]) == true}
    elsif !value
      return self.length
    else
      self.length.times {|i| count += 1 if self[i] == value}
    end
    return count
  end
  def my_map
  end


end

array = (1..100).to_a.shuffle


# array.my_each {|x| puts x}
# array.my_each_with_index {|x, i| puts x.to_s + "\t" + i.to_s}

#puts array.select {|x| puts x}
a =  array.my_select{|x| x%2 == 0}
a =  array.my_select{|x| x%2 == 0}.my_all?{|x| x%2 == 0}
a = array.my_any?{|x| x== 10000}
# Benchmark.bm do |x|

#   x.report {100.times{array.my_none?{|x| x== 10}}}     #occasionally some inexplicably high numbers
#   x.report {100.times{array.my_none2?{|x| x== 10}}}

# end
array.count{|x| x % 2 == 0}
p array.my_count{|x| x % 2 == 0}

p array.my_count(3)
p array.my_count
p a
