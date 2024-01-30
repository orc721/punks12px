require 'cocos'


meta = read_csv( './punks12px.csv' )
puts "  #{meta.size} meta record(s)"



## normalize names - remove all (A), (XL), etc.
##   note: use non-greeed +?
def norm( str )
   str.gsub( /\(
                [^)]+?
              \)/x, '' ).strip
end



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



write_json( "./tmp/inscriptions.json", recs )

puts "bye"
