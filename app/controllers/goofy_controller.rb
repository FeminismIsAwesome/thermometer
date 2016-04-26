require 'net/http'

class GoofyController < ActionController::Base
  def index
    base_url = 'https://raas.cloud.clickandpledge.com/report/26787/13a60ce2ce8b4c28b2fa/tm1000/0/0'
    request_url = "#{base_url}/#{params[:url]}"
    puts "request url: #{request_url}"
    url = URI.parse(URI.escape(request_url))
    req = Net::HTTP::Get.new(url.to_s)
    res = `curl #{url.to_s}`
    xml_doc  = Nokogiri::Slop(res)
    headers['Access-Control-Allow-Origin'] = "*"
    render json: {data:  xml_doc.children[0].elements[0].children.to_s}
  end
end
