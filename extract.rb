require 'nokogiri'
require 'csv'

doc = Nokogiri::HTML($<.read)
io = $stdout.dup
CSV(io) do |csv|
  doc.xpath('//colgroup').remove
  doc.xpath('//table//th[@class="first"]').remove
  doc.xpath('//table//td[@class="first"]').remove
  doc.xpath('//table//td[@class="treKnapp bubble"]').remove
  doc.xpath('//table//tr[@class="group"]').remove
  doc.xpath('//table//tr[@class="sort"]').remove
  doc.xpath('//table/tbody[position() > 1]/tr[1]').remove
  doc.xpath('//table//tr').each do |row|
    tarray = []
    row.xpath('th|td').each do |cell|
      tarray << cell.text.strip.gsub(/(\d+),(\d+)/, "\\1.\\2")
    end
    csv << tarray
  end
end
io.close
