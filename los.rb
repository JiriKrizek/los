#!/usr/bin/env ruby
#

x=['A','B','C','D','E','F']


# Round 1
for round in 0..2 do
puts "\n#{round+1}. kolo:"
  for i in 0..5 do
   shift_2=(i+(round*1))%6
   shift_3=(i+(round*2))%6
   shift_4=(i+(round*3))%6
   shift_4=(i+3+4)%6 if round==2

   puts "#{x[i]}1 #{x[shift_2]}2 #{x[shift_3]}3 #{x[shift_4]}4"
  end
end


