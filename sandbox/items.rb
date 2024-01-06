require 'cocos'
require 'digest'



items = []

nums = (0..9999)
# nums = (0..5)

nums.each do |num|
   puts "==> #{num}"
   name = "%04d" % num
   blob = read_blob( "./inscribe/punk#{name}.png" )

   hash = Digest::SHA256.hexdigest( blob )
 
   puts hash

   ## check if taken - must have hashckeck result
   inscriptionNumber =  if File.exist?( "./hashcheck/#{name}.json" )
                           2024  ## return dummy (not 1) for now 
                        else
                           1
                        end 
  
   items << { id: hash,
              name: "##{num}",
              image: "https://github.com/orc721/punks12px/raw/master/inscribe/punk#{name}.png",
              inscriptionNumber: inscriptionNumber
            }
end


path = "./docs/items.js"
write_json( path, items )

## hack to add const items = upfront
buf  = "// items.js generated on #{Time.now.utc}\n"
buf += "\n"

buf += " const items = " + read_text( path )
write_text( path, buf )

puts "bye"

