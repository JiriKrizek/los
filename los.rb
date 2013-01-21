#!/usr/bin/env ruby
# encoding: UTF-8
#

require './jmena'
people = People::PEOPLE

x=['A','B','C','D','E','F']
teams=0

if ARGV[0].nil? || ARGV[0].empty?
  puts "Required argument number of teams. (#{$0} [TEAMS])"
  exit
end
begin
    teams = Integer(ARGV[0])
  rescue ArgumentError => e
    puts "Required argument must be number"
    exit
end
if teams <= 0
  puts "Required argument must be positive number"
  exit
end

unless ARGV[1].nil?
  debug = ARGV[1].downcase.eql?("--debug")
else
  debug = false
end


(0..(teams-1)).each do |round|
puts "\n#{round+1}. kolo:"
  (0..teams-1).each do |i|
    shift_2=(i+(round*1))%teams
    shift_3=(i+(round*2))%teams
    shift_4=(i+(round*3))%teams
    shift_4=(i+3+4)%teams if round==2 && teams==6

    person_1 = "#{x[i]}1"
    person_2 = "#{x[shift_2]}2"
    person_3 = "#{x[shift_3]}3"
    person_4 = "#{x[shift_4]}4"

    if debug
     puts "#{person_1}\t#{person_2}\t#{person_3}\t#{person_4}"
    else
     puts "#{people[person_1]}\t#{people[person_2]}\t#{people[person_3]}\t#{people[person_4]}"
    end
  end
end


