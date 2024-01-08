require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks12px.i.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


STATS = Hash.new(0)

## skip if already inscribed on Jan/8th, 2024
TAKEN = [64, 91, 924,
         1012, 1080, 1219, 1422,
         3101, 3447, 3975,
         4526, 4724, 4756, 4770,
         5323, 5505, 5597,
         6308,
         7403,
         8299, 8877, 8888,
         9190]
 

srand( 4242 )   # make deterministic

def generate_punk( *values )

  id              = values[0].to_i(10)
  punk_type       = values[1]
  attribute_names = (values[2] || '' ).split( '/').map { |attr| attr.strip }
     

  ## turn every 10th male1/2/3/4 punk into alien
  ##                 female1/2/3/4 punk into alien

### more fun
  ##   turn every 10th male1 into blue
  if ['Orange', 'Pink Female', 'Gold',
      'Male 1', 'Female 1',
      'Male 3', 'Female 3',
      'Male 4', 'Female 4',
     ].include?( punk_type )

    count = STATS[ punk_type ] += 1  

    
      
      if   count % 10 == 0   && 
            !TAKEN.include?( id )    ## skip if already inscribed on Jan/8th, 2024
      
        alien1 = ['Alien Purple', 'Alien Blue']
        alien3 = ['Alien Green', 'Alien Red']
        alien4 = ['Alien']
   
        punk_type = case punk_type
                    when 'Male 1'   then  alien1[ rand(alien1.size)]
                    when 'Female 1' then  alien1[ rand(alien1.size)] + ' Female'
                    when 'Male 3'   then  alien3[ rand(alien3.size)]
                    when 'Female 3' then  alien3[ rand(alien3.size)] + ' Female'
                    when 'Male 4'   then  alien4[ rand(alien4.size)]
                    when 'Female 4' then  alien4[ rand(alien4.size)] + ' Female'
                    when 'Gold'         then 'Alien Gold' 
                    when 'Orange'       then 'Alien Orange'
                    when 'Pink Female'  then 'Alien Magenta Female'
                    else punk_type  ## fallback; shouldn't happen really
                    end
            
                    
        ## eyeshadow not really working for alien eyes
        ##   change to face "blemish"
        ## 1) move eyeshadow to first on stack 
        has_eyeshadow = nil
        attribute_names = attribute_names.select do |attribute_name|
                            case attribute_name
                            when 'Blue Eye Shadow',
                                 'Purple Eye Shadow',
                                 'Green Eye Shadow' then  has_eyeshadow=attribute_name; false
                            else true
                            end
                          end
         attribute_names = [has_eyeshadow]+attribute_names   if has_eyeshadow        

         ## 2) replace
        attribute_names = attribute_names.map do |attribute_name|
                               case attribute_name
                               when 'Blue Eye Shadow'  
                                  if attribute_names.join.include?( 'Lipstick')
                                    'Mole'
                                  else
                                    'Burgundy Lipstick'
                                  end
                               when 'Purple Eye Shadow' then 'Spots'
                               when 'Green Eye Shadow'  then 'Mole'
                               else attribute_name
                              end
      end
    end 
  end

  [id.to_s, punk_type, attribute_names.join( ' / ')]
end # method generate


##
# let's go - generate all 10 000 using the records

meta = []
recs.each_with_index do |rec,i|
  puts "==> punk #{i}:"
  pp rec

  meta << if i < 9975   
              generate_punk( *rec.values )
          else  ## last twenty five (pass along as i)
              rec.values
          end   
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

