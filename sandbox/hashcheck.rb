###
#  to run use:
#    $ ruby sandbox/hashcheck.rb


$LOAD_PATH.unshift( "../pixelart/ordbase/ordinals/lib" )
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
(0..9999).each do |i|
    num = '%04d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
        ## skip; already checked
    else
      item = items[i]
        ## note: start counting at 0/0
      puts "==> #{i}/#{items.size-1} #{item['name']}..."
      hash = item['id']
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