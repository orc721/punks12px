require 'cocos'


###
# todo/fix: 
#   check for duplicates!!!


meta = read_csv( './punks12px.csv' )
puts "  #{meta.size} meta record(s)"



## normalize names - remove all (A), (XL), etc.
##   note: use non-greeed +?
def norm( str )
   str.gsub( /\(
                [^)]+?
              \)/x, '' ).strip
end


duplicates = Hash.new(0)



recs = []

ids = (0..9999)
ids.each do |i|
    num = '%04d' % i
    path = "./hashcheck/#{num}.json"

    ## skip if no hashcheck data file
    next  unless File.exist?( path )

    data = read_json( path )
    inscribe = data['results'][0]['inscriptionid']

    puts "==> no. #{i}..."
    pp inscribe

    count =  duplicates[ inscribe ] += 1
    
    if count > 1
      puts "!! skipping duplicate"
      next
    end


    spec = meta[ i ]
    type       = norm( spec['type'] )
    accessories = (spec['attributes'] || '').split( '/' ).map {|acc| norm( acc ) }
 
    attributes = []
    attributes << { 'trait_type' => 'type',
                    'value'      => type }
    accessories.each do |acc|   ## change name to attribute (from accessory)
        attributes << { 'trait_type' => 'attribute',
                        'value'      => acc } 
    end
    attributes <<  { 'trait_type' => 'attribute count',
                     'value' => accessories.size.to_s }  ## number (type) possible?
 

    recs << {
               'id' => inscribe,
               'meta' => {
                 'name' => "Punk 12px \##{i}",
                 'attributes' => attributes
                }
            }
end


pp recs
puts "   #{recs.size } record(s)"



duplicates.each do |inscribe,count|
  if count > 1
     puts "!! #{count} - #{inscribe}"
  end
end


write_json( "./tmp/inscriptions.json", recs )

puts "bye"

__END__

!! 2 - a6df26b9a9bf4929a462370b55be0b253abaecdce23233b79041d262dfa46186i0
!! 2 - 4a30d3404008853fdb0f4205f3682f82958ff2ae9a318c93c21cc00cd4374dd5i0
!! 2 - 29882b3b5eabbbd5b002562279dbc67b75dcbf8088dd1be8e67f810a6ac43c1ei0
!! 2 - 57ce182866b320b52656c2d2cd01324ba87a234638f09f7aebad82fe968742aai0
!! 4 - 34ad982ab2992ddafda7072528d1e00571cf087472dab92b24e6a8c2e723f76ci0
!! 2 - 4c544c9137d1338c99db4b0868460f6fa33729ecea4857eb9c261c6f88ede8cai0
!! 3 - f9a4225b96878ad6da1624fa64cff7a097e4d412c96fe86f2a8150653d3f70fdi0
!! 2 - a2aea0c6576d8bdfbe4a4a3a28aeaee5e2b45d3281d66ae36aa647154a7e1096i0
!! 2 - 667e4cd5672ef0bd46cdd5117d40c0546e0a87532fcfb498201904cb5cc1bed6i0
!! 3 - 7fd4296151c6f669897705e2bc2938a8d14adee825646ca6ec84f367afba8705i0
!! 3 - 8381882dc8e6656d4af592e6c1a88460061267dce00561b0a0831d4c7989523di0
!! 2 - f4079a9afafaa1fd8545432f99195e325afe5ea0d851201441ecb925b599fd1ei0
!! 2 - 5bac4ca2e7bb0ca6d7e5fb4dc4906cbdbb479ee4cb404f8c8ae1367ab4d5a431i0
!! 2 - 2a17658fa295d61ecbcfe4822e1ed725dac2673fc55e3e489a39c6b45f078e6bi0
!! 2 - 31497a6f6808d05f1fde30530669123a94304856e55003a623f78abc827cada0i0
!! 3 - 4aaa3d7d0069710bac471075c3c7a21f367226e920ee108f6529bbdd940fbfedi0
!! 2 - cad22866463100135b4f86b0fde9735caf3a0f3d4e4475f24a94208f692c3ccfi0
!! 2 - a8339083272c6d3b32303fab783dffb4a303b2c8d7c421a7d3003e5cb44d8099i0
!! 3 - a3ba786cf31a721fc92c99ca99926e060ca99bf99642a6defc0e7cd33500af55i0
!! 2 - 5b6c0c16040ea1dff30316ff82ea26427465972c1b7418b939f3fa8b958034bdi0
!! 2 - 0d85e02c53d0203bba23505199f6ee78055be9da6675275c6bc9abf14d5dd696i0
!! 3 - 8947bd1ad8818a2895949bd09c8b70e4d90bc35a6bb8e2a0f290b1bb2eef87c3i0
!! 2 - 2ffe3ddb3fbb3143569011de2e74a815147b9558ca7dee9b8945b07c02042426i0
!! 2 - 104800b0767982f0216a39bb62dbc87fc0b75def0fbad5630972e1cea76a0e1fi0
!! 2 - 90bd63e9d29edd5cbafa42bbfa12dc764594ef12160f4e87bcf74c9bd19cbfd3i0
!! 2 - cdebe3a9009fd1bfc5cb3a15cbb02942a855be5a9de6a58b312a987989bb9f0bi0
!! 2 - 1cc5e85ad107c22b0c327e20996046e84997b5c56c1670516d4b6a8ed1723520i0
!! 2 - 519ff06c0d0217e2ed94117d006a733cd405cf1f94cc1d139317692d52c262c2i0
