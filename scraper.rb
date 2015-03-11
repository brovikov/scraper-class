
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :source, :filename

  def initialize(source, filename)
    @source = source
    @filename = filename
  end

  def scrap 
    page = Nokogiri::HTML(open(@source))   

    page.xpath('//img/@src').each do |img|
      img.content = URI.join( @source, img ).to_s
    end

    page.xpath('//link/@href').each do |link|
      link.content = URI.join( @source, link ).to_s
    end

    page.xpath('//script/@src').each do |script|
      script.content = URI.join( @source, script ).to_s
    end

    open(@filename, "wb") do |file|
      file.write(page)
    end
  end
end

#Example of usage
web = Scraper.new("http://www.ebay.com/" , "ebay.html")
web.scrap







