require 'faraday'

class APIConnection
  def self.connect_via_faraday(host)
    Faraday.new(:url => host) do |faraday|
      faraday.request  :url_encoded            
      faraday.response :logger                 
      faraday.adapter  Faraday.default_adapter
    end
  end
end
