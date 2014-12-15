
Beerday::Application.routes.draw do

  get 'beers' => 'beers#index'
  get 'beers/index'

  get 'breweries' => 'breweries#index'
  get 'breweries/index'
  
  get 'days' => 'days#index'
  get 'days/index'

  get 'feed' => 'feed#index'
  get 'feed/index'


  mount About::Server,     :at => '/sysinfo'
  mount DbBrowser::Server, :at => '/browse'
  ## mount sinatra app (bundled w/ logutils gem)
  mount LogDb::Server, :at => '/logs'    # NB: make sure to require 'logutils/server' in env


  mount BeerDbAdmin::Engine, :at => '/db' 

  root :to => 'date#index'

end
