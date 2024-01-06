###
#  to run use:
#    $ ruby sandbox/types.rb


require 'punks'


specs = parse_data( <<DATA )
  Alien Green
  Alien Purple Female
  Skeleton Female
  Blue Female
  Male 2
  Blue
  Alien Gold
  Orc Female
  Skeleton
  Orc
  Demon
  Bot
  Alien
  Ape
  Zombie
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
#=>  25 record(s)



composite = ImageComposite.new( 5, 5, width: 12, height: 12 )

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
