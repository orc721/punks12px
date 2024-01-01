require 'cocos'
require 'digest'



items = []

nums = (0..9999)
# nums = (0..5)

nums.each do |num|
   puts "==> #{num}"
   name = "%04d" % num
   blob = read_blob( ".//i/punk#{name}.png" )

   hash = Digest::SHA256.hexdigest( blob )
 
   puts hash

   inscriptionNumber =  1

   items << { id: hash,
              name: "##{num}",
              image: "https://github.com/orc721/punks12px/raw/master/i/punk#{name}.png",
              inscriptionNumber: inscriptionNumber
            }
end


write_json( "./items.js", items )

## hack to add const items = upfront
buf  = "// items.js generated on #{Time.now.utc}\n"
buf += "\n"

buf += " const items = " + read_text( "./items.js" )
write_text( "./items.js", buf )

puts "bye"

