xml.instruct!
xml.comment! "beer of the day feed"
xml.feed xmlns: "http://www.w3.org/2005/Atom" do
  xml.title "Beer-A-Day"
  xml.subtitle h("Cheers, Prost, Kampai, Na zdravi, Salute, 乾杯, Skål, Egészségedre!")
  xml.link feed_url()
  xml.updated @today.iso8601
  xml.author do
    xml.name "Beer-A-Day Service"
  end
  @days.each do |day|
    xml.entry do

      ## todo make it into a helper beer_title() ?? or similar
      title = ''
      if day.beer.brewery
        title << day.beer.brewery.title
        if day.beer.brewery.founded
          ## title << " (#{day.beer.brewery.founded})"
        end
        title << " @ #{day.beer.brewery.city.name}" 
        title << " › #{day.beer.brewery.region.name}"
        ## title << " › #{day.beer.brewery.country.name}"
      else
        title << '???'
      end

      xml.title "##{day.date.yday} - #{day.beer.title} / #{title}"
      xml.link href: date_url( date: day.date )
      xml.id "tag:#{day.beer.key}"
      xml.updated day.date.iso8601
      xml.summary  h(render(partial: 'shared/beer', locals: { beer: day.beer })), type: 'html'
    end
  end
end
