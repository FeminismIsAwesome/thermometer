require 'net/http'

class GoofyController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def set_cors_origin
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def index
    base_url = 'https://raas.cloud.clickandpledge.com/report/26787/13a60ce2ce8b4c28b2fa/tm1000/0/0'
    request_url = "#{base_url}/#{params[:url]}"
    puts "request url: #{request_url}"
    url = URI.parse(URI.escape(request_url))
    res = `curl #{url.to_s}`
    xml_doc  = Nokogiri::Slop(res)
    render json: {data:  xml_doc.children[0].elements[0].children.to_s}
  end
end
