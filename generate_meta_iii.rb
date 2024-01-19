require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks12px.ii.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


meta = recs.map { |rec| rec.values }


###
# add more ordinal (sub1k) punks  
specs = parse_data( <<DATA )


 
# presidents
9819, Joe
9820, Joe (A), Cap Blue
9821, Joe, Clown Eyes Blue, Clown Nose 
9822, Joe, 3D Glasses
9823, Joe, Regular Shades
9824, Joe (A), Cap Blue, Regular Shades
9825, Joe, Laser Eyes

9826, Donald
9827, Donald (A), Cap Red
9828, Donald (A), Cap McD
9829, Donald, Clown Eyes Green, Clown Nose
9830, Donald, 3D Glasses
9831, Donald, Laser Eyes
9832, Donald, Regular Shades

9833, Nikki
9834, Nikki (A)
9835, Nikki, Big Shades, Earring
9836, Nikki, 3D Glasses
9837, Nikki, Laser Eyes, Gold Chain
9839, Nikki (A), VR
9840, Nikki (B), Hoodie Red
 
  
# 1bits
9841, Ape 1Bit, Regular Shades Red
9842, Ape 1Bit, Regular Shades Green
9843, Ape 1Bit, Regular Shades Blue
9844, Ape 1Bit, Cap (1BIT), Regular Shades Red
9845, Ape 1Bit, Cap (1BIT), Regular Shades Green
9846, Ape 1Bit, Cap (1BIT), Regular Shades Blue
9847, Ape 1Bit, Cap (1BIT), Maxi Biz Laser Eyes Red
9849, Ape 1Bit, Cap (1BIT), Maxi Biz Laser Eyes Green
9850, Ape 1Bit, Cap (1BIT), Maxi Biz Laser Eyes Blue
9851, Bitmap 1Bit, Maxi Biz Laser Eyes Red
9852, Bitmap 1Bit, Maxi Biz Laser Eyes Green
9853, Bitmap 1Bit, Maxi Biz Laser Eyes Blue
9854, Ape 1Bit
9855, Bitmap 1Bit


# bitmaps
9856, Bitmap Orange
9857, Bitmap Orange,  Red Mohawk (BMP)
9858, Bitmap Orange,  Peak Spike, Regular Shades
9859, Bitmap Orange,  3D Glasses
9860, Bitmap Orange,  Laser Eyes
9861, Bitmap Orange,  Crazy Hair, Nerd Glasses
9862, Bitmap Orange,  Clown Eyes Green, Clown Nose
9863, Bitmap Orange,  Jester Hat, Clown Nose
9864, Bitmap Orange,  Cap Forward, Pipe (BMP)
9865, Bitmap Orange,  Cap McD
9866, Bitmap Orange,  Bandana, Regular Shades
9868, Bitmap Orange,  Purple Hair (BMP), Classic Shades, Earring

9869, Bitmap Pink   
9870, Bitmap Pink, Blonde Bob (BMP)
9871, Bitmap Pink, Blonde Bob (BMP), 3D Glasses   
9872, Bitmap Pink, 3D Glasses   
9873, Bitmap Pink, Laser Eyes    
9874, Bitmap Pink, Blonde Side, Big Shades, Gold Chain, Earring   
9875, Bitmap Pink, Blonde Short, Nerd Glasses   
9876, Bitmap Pink, Half Shaved Blonde (BMP)   
9877, Bitmap Pink, Choker, Red Mohawk (BMP), Heart Shades  
9879, Bitmap Pink, Pigtails Blonde, Classic Shades   
9880, Bitmap Pink, Wild Blonde (BMP), Mole
9881, Bitmap Pink, Tassle Hat, Clown Eyes Blue, Clown Nose   

# marcs
9883, Marc, Luxurious Beard, Clown Nose
9884, Marc XL, Cap McD Visor (XL)
9885, Marc XL, Bandana (XL), Eye Patch (XL)
9886, Marc XL, Cowboy Hat (XL), Earring (XL)

# readymades 
9887,  Mundl
9888,  Mundl, Sun Hat (A)
9889,  Mundl, Cigarette
9890,  Mundl, 3D Glasses

9891,  Frida
9892,  Frida,  3D Glasses
9894,  Frida (A),  Red Mohawk, Choker, Earcross, Green Lipstick
9895,  Frida (A), Hoodie Green
9896,  Frida (A), Hoodie White
9897,  Frida (A), Hoodie Red

9898, Da Vinci 
9899, Da Vinci, 3D Glasses
9900, Da Vinci (A), Laser Eyes
9902, Da Vinci (A), VR

9903, Van Gogh
9904, Van Gogh, 3D Glasses
9905, Van Gogh, Regular Shades
9906, Van Gogh, Regular Shades, Sun Hat

9907, Shakespeare, Earring
9908, Shakespeare, 3D Glasses, Earring
9910, Shakespeare,  Regular Shades, Earring
9911, Shakespeare,  Clown Eyes Green, Clown Nose, Earring

 ## orange pilled
 9912, Orange,  3D Glasses, Cap Red
 9913, Zombie Orange, Crazy Hair
 9915, Ape Orange, Knitted Cap, Earring, Bubble Gum
 9916, Alien Orange, Spots, Clown Nose, Clown Hair Blue

 9917, Demon Orange, Laser Eyes, Pipe
 9918, Orc Orange,  Eye Mask, Goat, Gold Chain 
 9919, Skeleton Orange, Bandana, Cigarette
 9920, Vampire Orange,  Purple Hair, Classic Shades
 9921, Mummy Orange, Hoodie
 9922, Bot Orange, Big Beard
 
 ## the saudis
 9923, Male 2, Normal Beard Black,  White Shemagh & Agal,  Laser Eyes Gold
 9924, Male 1, Shadow Beard, White Shemagh
 9925, Male 3, Mustache, Red Shemagh & Agal, Earring  
 9926, Male 2, Luxurious White Beard,  Brown Shemagh & Agal 

 9927, Male 1, White Shemagh & Gold Agal, Big Shades 
 9928, Male 3, Spots, Red Shemagh, Gold Chain, Pipe
 9929, Male 1, White Shemagh, Goat, Laser Eyes Gold
 9930, Male 2, White Shemagh & Agal, Clown Eyes Green, Clown Nose

 9931, Male 1, Chinstrap, Red Shemagh & Agal, Horned Rim Glasses  
 9932, Male 3, Normal Beard Black, Brown Shemagh & Agal, Small Shades 
 9933, Male 2, Shadow Beard, Red Shemagh, Nerd Glasses, Bubble Gum
 9934, Orange, White Shemagh & Gold Agal,  Laser Eyes


  ## bonus red aliens
  9935,  Alien Red, Shadow Beard,  Hoodie, Earring                     # inscribe no. 55473236
  9936,  Alien Red, Luxurious Beard, Hoodie, Laser Eyes Gold, Earring  # inscribe no. 55475227

  9937,  Male 4, Cowboy Hat, Tears, Frown      # cowboys dont cry
  
  ## ordinal punks (sub1k)
  9938,  Male 2, Birthday Hat, Bubble Gum   #2
  9939,  Male 1, Cap Burger King    #7
  9940,  Female 1, Bow  #19
  9941,  Zombie Female, Birthday Hat, VR   #39
  9942,  Blue, Cap Burger King, Classic Shades  #46
  9943,  Ape Gold, Laser Eyes  #0
  9944,   Female 1, Flowers, Gold Chain   #3
  9945,   Ape Blue, Buck Teeth, Cowboy Hat  #5
  9946,    Vampire, Demon Horns   #8
  9947,    Ape Zombie, Bubble Gum  #20
  9948,     Male 2, Sombrero, Mustache   #25
  9949,    Vampire, Bubble Gum, Spots, Do-rag  #26
  9950,    Mummy, Beanie   #27
  9954,    Male 2, Jester Hat  #30
  9956,    Male 1, Cap Red    #31
  9957,    Male 1, Buck Teeth, 3D Glasses, Cigarette   #37
  9958,    Mummy, Crown    #41
  9959,    Demon Female, Cigar, Choker  #42
  9960,    Female 4, Frumpy Hair, Nerd Glasses   #43
  9961,    Ape Alien, Goat, Fedora  #50
  9963,    Demon Female, Frumpy Hair, Clown Nose  #53
  9964,    Male 3, Heart Shades, Do-rag  #54
  9966,    Vampire Female, Heart Shades  #58
  9967,    Ape Female, Sombrero  #66
  9968,    Mummy, Dark Hair      #72
  9969,    Orc                  #80 
  9970,    Vampire Female, Dark Hair   #81
  9971,    Mummy, Cowboy Hat, Eye Mask (A)    # 82
  9973,    Vampire,   Demon Horns, Chinstrap  #90
  9974,    Ape Alien, Eye Patch, Frumpy Hair  #94  
DATA



specs.each do |values|
   id = values[0].to_i(0)
   meta[ id ] = [ 
                    id.to_s, 
                    values[1], 
                    values[2..-1].join( ' / ')
                  ]
end


headers = ['id', 'type', 'attributes']
File.open( "./punks12px.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end

puts "bye"

