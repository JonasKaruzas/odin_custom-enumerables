# My additions to the Enumerable module
module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    result_arr = []
    self.my_each do |item| 
      result_arr.push(item) if yield item 
    end

    result_arr
  end


end

puts '-- my_each vs. each --'
numbers = [3, 4, 5, 4, 3]
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts '-- my_each_with_index vs. each_with_index --'
numbers = [3, 4, 5, 4, 3]
numbers.my_each_with_index { |item, idx| puts "item - #{item}, index - #{idx}" }
numbers.each_with_index { |item, idx| puts "item - #{item}, index - #{idx}" }

puts '-- my_select vs. select --'
numbers = [3, 4, 5, 4, 3, 2, 8, 9, 24]
p numbers.my_select { |n| n.even? }
p numbers.select { |n| n.even? }
