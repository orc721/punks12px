
module ApplicationHelper

  def beer_facts( beer )
    buf = ''
    facts = []
    facts << "#{beer.abv}%" if beer.abv.present?
    facts << "#{beer.og}°" if beer.og.present?
    buf << "(#{facts.join(', ')})" if facts.size > 0
    buf
  end

end
