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

  def my_all?
    self.my_each do |item|
      return false unless yield item
    end
    true
  end

  def my_any?
    self.my_each do |item|
      return true if yield item
    end
    false
  end

  def my_none?
    self.my_each do |item|
      return false if yield item 
    end
    true
  end

  def my_count
    result = 0
    self.my_each do |item|
      result += 1 if yield item
    end
    result
  end

  def my_map(my_proc = nil)
    result = []
    self.my_each do |item|
      result.push(if my_proc
                    my_proc.call(item)
                  else
                    yield item
                  end
                  )
    end
    result
  end

  def my_inject
    acc = 0
    self.my_each do |item|
      acc = yield acc, item
    end
    acc
    
  end

end

numbers = [3, 4, 5, 4, 3, 2, 8, 9, 24]

puts '-- my_each vs. each --'
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts '-- my_each_with_index vs. each_with_index --'
numbers.my_each_with_index { |item, idx| puts "item - #{item}, index - #{idx}" }
numbers.each_with_index { |item, idx| puts "item - #{item}, index - #{idx}" }

puts '-- my_select vs. select --'
p numbers.my_select { |n| n.even? }
p numbers.select { |n| n.even? }

words = %w[ant bear cat bird]

puts '-- my_all? vs. all? --'
p words.my_all? { |word| word.length >= 3 }
p words.my_all? { |word| word.length >= 4 }
p words.all? { |word| word.length >= 3 }
p words.all? { |word| word.length >= 4 }

puts '-- my_any? vs. any? --'
p words.my_any? { |word| word.length >= 3 }
p words.my_any? { |word| word.length >= 4 }
p words.my_any? { |word| word.length == 2 }
p words.any? { |word| word.length >= 3 }
p words.any? { |word| word.length >= 4 }
p words.any? { |word| word.length == 2 }

puts '-- my_none? vs. none? --'
p words.my_none? { |word| word.length == 5 }
p words.my_none? { |word| word.length >= 4 }
p words.none? { |word| word.length == 5 }
p words.none? { |word| word.length >= 4 }

puts '-- my_count vs. count --'
p numbers.my_count { |x| x%2==0 }
p numbers.count { |x| x%2==0 }

puts '-- my_map vs. map --'
p numbers.my_map { |x| x * x }
p numbers.map { |x| x * x }

puts 'map proc'
my_proc = Proc.new {|item| item * 100}
p numbers .my_map(&my_proc)

puts '-- my_inject vs. inject --'
p numbers.my_inject { |sum, n| sum + n }  
p numbers.inject { |sum, n| sum + n }  