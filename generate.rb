$LOAD_PATH.unshift( "../pixelart/cryptopunks/punks/lib" )
require 'punks'



specs = read_csv( "./punks12px.csv" )



specs.each_with_index do |rec, i|
     ## quick hack/fix:  
     ## note: do NOT regenerate 9987 - blue female type changed (e.g. mouth color)!!!!
     ## 9987, Blue Female, Nerd Glasses / Blonde Short
     next if [9987].include?( i )
     

     ## next unless [9935, 9936].include?( i )
     next if i < 9885

     base        = rec['type']
     attributes = (rec['attributes'] || '' ).split( '/').map { |attr| attr.strip }
     
     spec = [base] + attributes

     img = Punk12::Image.generate( *spec )
      
     num = "%04d" % i
     puts "==> punk #{num}"
     img.save( "./inscribe/punk#{num}.png" )
     # img.zoom(8).save( "./tmp/@8x/punk#{num}@8x.png" )
end


puts "bye"

