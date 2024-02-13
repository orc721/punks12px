###
#  to run use:
#    $ ruby sandbox/unminted.rb


require 'cocos'

unminted = []
(9700..9999).each do |i|
    num = '%04d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
        ## skip; already checked
    else
       unminted << i
    end
end



pp unminted
puts "  #{unminted.size} mint(s) available"
#=> 65 mint(s) available

puts "bye"



