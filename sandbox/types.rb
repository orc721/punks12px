###
#  to run use:
#    $ ruby sandbox/types.rb

$LOAD_PATH.unshift( "../pixelart/cryptopunks/punks/lib" )
require 'punks'


## 34 types

specs = parse_data( <<DATA )
  Blue Female
  Male 2
  Blue
  Skeleton Female
  Skeleton
  Orc
  Orc Female
  Demon
  Bot
  Ape
  Alien Gold
  Alien Female
  Alien Blue Female
  Alien Green Female
  Alien Red Female
  Alien Purple Female
  Alien
  Alien Purple
  Alien Blue
  Alien Green
  Zombie
  Alien Red
  Alien Magenta Female
  Alien Orange
  Gold
  Pepe
  Female 4
  Male 4
  Female 1
  Female 3
  Pink Female
  Male 1
  Male 3
  Orange
DATA
puts "   #{specs.size} record(s)"



composite = ImageComposite.new( 6, 6, width: 12, height: 12 )

specs.each_with_index do |rec, i|
    name        = rec[0]
    key         = name.downcase.gsub( ' ', '_' )
    
    img = Punk12::Image.generate( name )

    img.save( "./tmp3/#{key}.png" )
    img.zoom(4).save( "./tmp3/@4x/#{key}@4x.png" )
    img.zoom(10).save( "./tmp3/@10x/#{key}@10x.png" )
    
    composite << img  
end

composite.save( "./tmp/types.png" )
composite.zoom(4).save( "./tmp/types@4x.png" )


puts "bye"
