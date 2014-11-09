
require 'fetcher'

####
# download tasks for zips

def dowload_archive( url, dest )

  puts "downloading #{url} to #{dest}..."
  worker = Fetcher::Worker.new
  res = worker.get( url )
  ## save as binary (do NOT use any charset conversion)
  ## - worker.copy( world_url, world_dest ) - not working for now/ fix??

  puts "#{res.code}  #{res.message}"
  puts "content-type: #{res.content_type}, content-length: #{res.content_length}"

  File.open( dest, 'wb' ) do |f|
    f.write( res.body )
  end

  ## print some file stats
  puts "size: #{File.size(dest)} bytes"
end



ZIP_PATH    = './tmp'

WORLD_URL        = 'https://github.com/openmundi/world.db/archive/master.zip'
WORLD_ZIP_NAME   = 'world.db'
WORLD_ZIP  = "#{ZIP_PATH}/#{WORLD_ZIP_NAME}.zip"

AT_CTY_URL  = 'https://github.com/openmundi/austria.db/archive/master.zip'
AT_CTY_ZIP_NAME  = 'austria.db'
AT_CTY_ZIP = "#{ZIP_PATH}/#{AT_CTY_ZIP_NAME}.zip"


AT_BEER_URL  = 'https://github.com/openbeer/at-austria/archive/master.zip'
AT_BEER_ZIP_NAME  = 'at-austria'
AT_BEER_ZIP = "#{ZIP_PATH}/#{AT_BEER_ZIP_NAME}.zip"

BE_BEER_URL  = 'https://github.com/openbeer/be-belgium/archive/master.zip'
BE_BEER_ZIP_NAME  = 'be-belgium'
BE_BEER_ZIP = "#{ZIP_PATH}/#{BE_BEER_ZIP_NAME}.zip"


desc 'download world.db zip archive to /tmp/world.db.zip'
task :dl_world do
  puts "pwd: #{Dir.pwd}"  ## for debugging - print current working directory

  dowload_archive( WORLD_URL, WORLD_ZIP )
end


task :dl_at do
  dowload_archive( AT_CTY_URL, AT_CTY_ZIP )
  dowload_archive( AT_BEER_URL, AT_BEER_ZIP )
end


task :dl_be do
  dowload_archive( BE_BEER_URL, BE_BEER_ZIP )
end


task :load_world => [:environment]  do
  LogDb.delete!
  ConfDb.delete!
  TagDb.delete!
  BeerDb.delete!
  WorldDb.delete!

  WorldDb.read_setup_from_zip( WORLD_ZIP_NAME, 'setups/sport.db.admin', ZIP_PATH, { skip_tags: true } )
end

task :load_at => [:environment]  do
  WorldDb.read_setup_from_zip( AT_CTY_ZIP_NAME, 'setups/all', ZIP_PATH, { skip_tags: true } )

  TagDb.delete!
  BeerDb.delete!  # danger zone! deletes all records
  
  BeerDb.read_setup_from_zip( AT_BEER_ZIP_NAME, 'setups/all', ZIP_PATH )
end


task :load_be => [:environment] do
  TagDb.delete!
  BeerDb.delete!  # danger zone! deletes all records

  BeerDb.read_setup_from_zip( BE_BEER_ZIP_NAME, 'setups/all', ZIP_PATH )
end

