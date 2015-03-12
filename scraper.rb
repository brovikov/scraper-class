require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :source, :name

  def initialize(source, name)
    @source = source
    @name = name
    @AppRoot = File.expand_path(File.dirname(__FILE__)) + "/"
  end

  def scrap 
    system 'mkdir', '-p', @AppRoot + @name
    scraproot =  @AppRoot + @name
    system 'mkdir', '-p', scraproot + "/img"
    system 'mkdir', '-p', scraproot + "/js"
    system 'mkdir', '-p', scraproot + "/css"

    page = Nokogiri::HTML(open(@source))   

    e = /^.*\.(jpg|JPG|gif|GIF|png|PNG|tiff|tif|TIFF|TIF)/
    
    n=0
    page.xpath('//img/@data-src', '//img/@src').each do |img|
      filename = scraproot +'/img/' + n.to_s + File.basename(img.value, ".*") + "." + 
        e.match(File.extname(img.value)).to_a.last.to_s
	open(filename , 'wb') do |file|
        file << open(URI.join( @source, img.value ).to_s).read
        img.content = filename
	end
	 n += 1
    end

    n=0
    page.xpath('//link/@href').each do |link|
      filename = scraproot +'/css/' + n.to_s + ".css"
      open(filename, 'wb') do |file|
        begin
          open(URI.join( @source, link.value ).to_s).read
          rescue 
          else
            file << open(URI.join( @source, link.value ).to_s).read
       end
        link.content = filename
      end
      n = n + 1
    end
    
    n=0
    page.xpath('//script/@src').each do |script|
      filename = scraproot +'/js/' + n.to_s + File.basename(script.value) 
      open(filename, 'wb') do |file|
        file << open(URI.join( @source, script.value ).to_s).read
        script.content = filename
      end
    n = n + 1
    end
    open(scraproot + "/" + @name + ".html", "wb") do |file|
      file.write(page)
    end
  end
end

#Example of usage
web = Scraper.new("http://ebay.com" , "shop")
web.scrap







