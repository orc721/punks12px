##
#
#
#
# print todays date
#
# print week number
# print day number
# print weekday (mo,tu,etc)
# print month

require 'date'

puts "today's date is #{Time.now}"

t = Time.now

puts "day:   #{t.day}"
puts "month: #{t.month}"
puts "year:  #{t.year}"
puts ""

## sunday is 0
## monday is 1
## tuesday is 2
## wednesday is 3
## thursday is 4
## friday is 5
## saturday is 6

WDAY = {
  0 => 'Sunday',
  1 => 'Monday',
  2 => 'Tuesday',
  3 => 'Wednesday',
  4 => 'Thursday',
  5 => 'Friday',
  6 => 'Saturday'
}

puts "wday:  #{t.wday}"
puts "WDAY:  #{WDAY[t.wday]}"
puts "yday:  #{t.yday}"

puts "week:  #{t.strftime('%W') }"   ## week starting monday (to sunday)

## Sunday -> Saturday is only American standard. International standard is Monday -> Sunday.
##
## Use %W instead of %U, it uses Monday as the first day of the week.

=begin
today's date is 2014-11-04 20:09:12 +0100
day:   4
month: 11
year:  2014

wday:  2
WDAY:  Tuesday
yday:  308
week:  44
=end
