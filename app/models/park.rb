class Park < ActiveRecord::Base

  require 'nokogiri'
  require 'open-uri'
  has_many :events

  @@numParks = 250

  def self.validator(doc)
    status = true
    if doc.at('COVParksFacilities') != nil
      docParksFacilities = doc.xpath('COVParksFacilities')
      parks = doc.xpath("//*[@ID]")
      if parks.size > 0 && parks.size < @@numParks
        for i in 0..parks.size-1
          park = parks[i].xpath('Name')
          if park == nil
            status = false
          end
        end
      else 
        status = false
      end
    else
      status = false
    end
    return status
  end

  def self.XMLparser
    Park.destroy_all
    suckr = ImageSuckr::GoogleSuckr.new
    doc = Nokogiri::XML(open('ftp://webftp.vancouver.ca/opendata/xml/parks_facilities.xml'))
    if validator(doc)
      doc.xpath("//Park").each do |node|
        puts "Park ID = " + node.attr("ID")
        parkname = node.at("Name").text
        image_url = suckr.get_image_url({"q" => "#{parkname} Vancouver"})
        Park.create!(
          id: (node.attr("ID")).to_i,
          name: node.at("Name").text,
          streetNumber: node.at("StreetNumber").text.to_i,
          streetName: node.at("StreetName").text,
          ewStreet:node.at("EWStreet").text,
          washroom:node.at("Washroom").text,
          nsstreet:node.at("NSStreet").text,
          googleMapDest:node.at("GoogleMapDest").text,
          hectare:node.at("Hectare").text,
          image_url: image_url
          )
      end
    else
      Rails.logger.info(">>>>>>>>>>>>>>> ERROR: INVALID XML RECEIVED <<<<<<<<<<<<<<<")
    end
  end
  
end