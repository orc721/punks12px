require 'cocos'


##
# read in all meta data records of all 10 000 punks (24px)
recs = read_csv( './punks12px.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values

recs.each do |rec|
  type = rec['type']

  counter[ type ] += 1
end

pp counter

counter = counter.sort { |l,r| l[1]<=>r[1] }

counter.each do |name,count|
  percent =  Float(count*100)/Float(recs.size)

  key = name.downcase.gsub( ' ', '_' )
  puts "| ![](i/#{key}@4x.png) %-12s  | %4d  (%5.2f %%) |" % [name, count, percent]
end

counter.each do |name,count|
  puts name
end


puts "  #{counter.size} type(s)"


puts "bye"
