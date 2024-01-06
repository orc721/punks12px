require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks24px.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


def generate_punk( *values  )
  ## remove empty attibutes
  values = values.select { |value| !value.empty? }

  punk_type       = values[0]
  attribute_names = values[1..-1]

  # change mid
  #  female to pink
  #  male   to orange 
  punk_type = case punk_type
              when 'Female 2' then 'Pink Female'
              when 'Male 2'   then 'Orange'
              else punk_type
              end 

  # change smile  to gold
  # change frown  to pepe
  punk_type = 'Gold'  if attribute_names.include?( 'Smile' )
  punk_type = 'Pepe'  if attribute_names.include?( 'Frown' )
    
  ## attributes - rm smile, frown
  attribute_names = attribute_names.select do |attribute_name|
                              case attribute_name
                              when 'Smile' then false
                              when 'Frown' then false
                              else true
                              end
                         end
 
  ## eyeshadow not really working for pink with blue eyes
  ##   change to face "blemish"                       
  if punk_type == 'Pink Female'
    attribute_names = attribute_names.map do |attribute_name|
        case attribute_name
        when 'Blue Eye Shadow'   then 'Rosy Cheeks'
        when 'Purple Eye Shadow' then 'Spots'
        when 'Green Eye Shadow'  then 'Mole'
        else attribute_name
        end
    end
  end


  attribute_names = attribute_names.map do |attribute_name|
                                        case attribute_name
                                        when 'Small Shades'    then 'Laser Eyes'
                                        when 'Welding Goggles' then 'Laser Eyes'
                                        else attribute_name
                                        end
                                     end

  [punk_type, *attribute_names]
end # method generate


##
# let's go - generate all 10 000 using the records

meta = []
recs.each_with_index do |rec,i|
  puts "==> punk #{i}:"
  pp rec

  values = rec.values
  attributes = generate_punk( *values )

  type            = attributes[0]
  more_attributes = attributes[1..-1]

  meta << [i.to_s, type, more_attributes.join( ' / ')]   
end

## overwrite last twenty five

###
# ordinal (sub1k) punks  
specs = parse_data( <<DATA )
   Bot, Big Beard   #1
   Demon, Hoodie, Pipe  #4
   Female 3, Mole, Choker, Wild White Hair,  Big Shades, Cigarette   #10 
   Zombie, Mole, 3D Glasses, Big Beard, Earring   #11  
   Orc, Beanie, VR, Clown Nose   # 12
   Demon, Cigarette, Laser Eyes   # 17
   Alien Gold, Top Hat, Silver Chain    # 21
   Blue, Clown Hair Blue    # 22 
   Skeleton, Eye Patch, Fedora    #35
   Orc Female, Blonde Bob   # 38 
   Male 2, Bandana, Laser Eyes  # 40
   Gold, Cap Forward, Laser Eyes  #48
   Blue Female, Nerd Glasses, Blonde Short  # 51
   Skeleton Female, Bandana, Cigarette    #55
   Orc Female, Mole, Frumpy Hair, Green Eye Shadow    #64
   Bot, 3D Glasses   #69
   Alien Purple Female, Pipe, Knitted Cap   #73
   Demon, Big Beard    #75
   Bot, Classic Shades, Cigarette  #76
   Zombie, Pipe, Hoodie, Pipe  #78
   Alien Green, Clown Eyes Green    #84   ## was blue - possible??
   Skeleton, Clown Eyes Green   # 86
   Bot, Crazy Hair   # 92
   Orc, Eye Mask, Goat, Gold Chain   # 93
   Female 3, Medical Mask, Cigarette    # 95
DATA


specs.each_with_index do |values, i|
   meta[9975+i] = [ 
                    (9975+i).to_s, 
                    values[0], 
                    values[1..-1].join( ' / ')
                  ]
end


headers = ['id', 'type', 'attributes']
File.open( "./tmp/punks12px.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end

puts "bye"

