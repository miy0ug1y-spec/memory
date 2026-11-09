class AiMessagesController < ApplicationController
  def create
    @chat = Current.user.ai_chats.find(params[:ai_chat_id])
    @chat.ai_messages.create!(
      role: "user",
      content: params[:message]
    )
    messages = @chat.ai_messages.order(:created_at, :id)

    uri = URI("http://127.0.0.1:8001/chat")

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"

    request.body = {
      messages: messages.map do |message|
        {
          role: message.role,
          content: message.content
        }
      end  
      }.to_json

    response = http.request(request)
    
    if response.is_a?(Net::HTTPSuccess)

      result = JSON.parse(response.body)

      @chat.ai_messages.create!(
        role: "assistant",
        content: result["reply"]
      )

    else
      flash[:alert] = "AIから返答を取得できませんでした。"  
    end

      redirect_to ai_chat_path(@chat)
  
  end
end
