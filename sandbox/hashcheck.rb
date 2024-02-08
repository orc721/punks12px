###
#  to run use:
#    $ ruby sandbox/hashcheck.rb


$LOAD_PATH.unshift( "../../ordbase/ordbase/ordinals/lib" )
require 'ordinals'


txt = read_text( "./docs/items.js ")
txt = txt.sub( /\A
                 [^\[]+?
                (?=\[)
                   /x, '' )  # strip everying (non-greedy) up to open bracket []

items = JSON.parse( txt )
pp items[0,2]


## last run
## continue at ==> 5184/9999


###  items = items[0,10000]    ## cut-off - first 100, etc.
# items = items[0,100]
# (8295..9999)

## ==> 3009/9999 #3009..
## 8240

## cont. / restart at.
## ==> 8651/9999 #8651.



# ids = (0..999)   ## hash check first thousand
# ids = (1000..1999)   ## hash check first thousand
# ids = (2000..9900)   ## hash check first thousand

# ids = (9000..9999)   ## hash check first thousand

# ids = (9880..9999)  ## hash check last 100
# ids = (5000..9999)  ## hash check last 100
ids = (9730..9999)
# ids = [9935, 9936]
# ids = (0..9999)
ids.each do |i|
    num = '%04d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
        ## skip; already checked
    else
      item = items[i]
        ## note: start counting at 0/0
      puts "==> #{i}/#{items.size-1} #{item['name']}..."
      hash = item['id']

      ## use reference image hash
      blob = read_blob( "./inscribe/punk#{num}.png" )
      hash = Digest::SHA256.hexdigest( blob )


      data = Ordinalsbot.hashcheck( hash )

      puts "  #{data['status']} #{data['count']}"

      if data['status'] != 'ok'
        puts "!! ERROR - expected status ok, got:"
        pp data
        exit 1
      end

      ## note: only write-out - if count greater one!!!
      write_json( path, data )    if data['count'] > 0
    end
end



puts "bye"



__END__

{
  "status": "ok",
  "results": [

  ],
  "count": 0,
  "totalItems": 0,
  "totalPages": 0,
  "currentPage": 1
}