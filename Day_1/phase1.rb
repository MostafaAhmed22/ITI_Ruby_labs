
scores = []

print "how many scores? "
total = gets.to_i
total.times do |index|
  print "enter score #{index + 1}: "
  value = gets.to_i
  scores << value
end

average = scores.sum.to_f / scores.size

highest = scores.max
lowest = scores.min

grade = case average
        when 90..100 then 'A'
        when 80..89  then 'B'
        when 70..79  then 'C'
        when 60..69  then 'D'
        else 'F'
        end


puts "results:"
puts "  average : #{average.round(2)}"
puts "  grade   : #{grade}"
puts "  highest : #{highest}"
puts "  lowest  : #{lowest}"
