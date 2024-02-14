require 'pixelart'

## 20
##  note:     9818 is "vanilla" 
ids  = [
    9729,
    9760,
    9761,
    9763,
    9765,
    9766,
    9776,
    9777,
    9780,
    9820,
    9824,
    9834,
    9835,
    9836,
    9837,
    9839,
    9916,
    9918,
    9920,
    9960
]

cols = 10
rows = ids.size / cols 
rows += 1    if ids.size % cols != 0
fam = ImageComposite.new( cols, rows, height: 12, width: 12 )


ids.each do |id|
    num = '%04d' % id
    fam << Image.read( "./inscribe/punk#{num}.png" )
end

fam.save( "./tmp/freemints.png" )
fam.zoom(4).save( "./tmp/freemints@4x.png" )


puts "bye"
