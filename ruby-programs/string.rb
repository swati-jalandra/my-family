class String
  def group_by_length
    split(' ').
        group_by(&:length)
        .sort.to_h
  end
end

str = 'i love my india i love my country ram is not here'
str.group_by_length.each do |key, value|
  puts "Length #{key}: #{value}"
end

