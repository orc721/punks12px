####
# e.g. use like
#   rake db:seed WORLD=f   or
#   rake db:seed WORLDDB=skip

skip_worlddb_str =  ENV['WORLD'] || ENV['WORLDDB']

if skip_worlddb_str.present? && ['f', 'false', 'skip'].include?( skip_worlddb_str )
  skip_worlddb = true
  puts 'skipping setup for world.db'
else
  skip_worlddb = false
end


LogDb.delete!
WorldDb.delete!  unless skip_worlddb    # danger zone! deletes all records
TagDb.delete!
BeerDb.delete!  # danger zone! deletes all records


unless skip_worlddb
  WorldDb.read_setup( 'setups/sport.db.admin', find_data_path_from_gemfile_gitref('world.db'), { skip_tags: true } )
  WorldDb.read_setup( 'setups/old', find_data_path_from_gemfile_gitref('austria.db'), { skip_tags: true } )
end


beerdb_setups = []

beerdb_setups +=[
  ['at-austria', 'all'],
]


beerdb_setups.each do |setup|
  BeerDb.read_setup( "setups/#{setup[1]}", find_data_path_from_gemfile_gitref( setup[0]) )
end


puts 'Done. Bye.'

