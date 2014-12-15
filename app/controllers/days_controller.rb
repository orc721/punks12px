
class DaysController < ApplicationController

  def index
    @days = Day.order(:date)
  end

end

