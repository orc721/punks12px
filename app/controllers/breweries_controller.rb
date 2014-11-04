
class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.order(:id)
  end

end
