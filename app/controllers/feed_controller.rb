
class FeedController < ApplicationController

  def index
    today = Date.today
    @days  = Day.where( date: today..(today-10.days) ).order(:date)
    @days2 = Day.where( "date >= '#{today}' AND date <= '#{today-10.days}'" ).order(:date)

    render :text => "count: #{@days.count}, count2: #{@days2.count}"
  end

end

