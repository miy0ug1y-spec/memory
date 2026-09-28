require "net/http"
require "json"

class AiChatsController < ApplicationController
  def new 
  end

  def create
    uri = URI("http://127.0.0.1:8001/chat")

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"

    request.body = {
      message: params[:message]
    }.to_json

    response = http.request(request)
    puts response.body

    result = JSON.parse(response.body)

    @reply = result["reply"]
  
    render :new
  end

end
