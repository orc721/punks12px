require 'pixelart'


recs = read_csv( "punks12px.csv" )
puts "    #{recs.size} record(s)"

punks =  recs.select { |rec| rec['type'].index( 'Alien' ) }
puts "    #{punks.size} punk record(s)"
#=> 944 punk record(s)



composite = ImageComposite.new( 10, 10, 
                                  width: 12, height: 12 )

                                  
punks[0,100].each do |punk|
    num =  "%04d" % punk['id'].to_i(10)
    img = Image.read( "./inscribe/punk#{num}.png" )

    composite << img
end


composite.save( "./tmp/aliens.png" )
composite.zoom(4).save( "./tmp/aliens@4x.png" )

puts "bye"