require "net/http"
require "json"

class AiChatsController < ApplicationController
  def new 
  end

  def create
    @chat = Current.user.ai_chats.create!
    redirect_to ai_chat_path(@chat)
  end

  def show
    @chat = Current.user.ai_chats.find(params[:id])
    @messages = @chat.ai_messages.order(created_at: :asc) 
  end


end
