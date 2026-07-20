class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @search_type = params[:search_type]
    @match_type = params[:match_type]

    @posts = Post.none
    @user = User.none

    return unless @keyword.present?
      case @search_type
      when "post"
          @posts = Post.published.where(
            "title LIKE :keyword OR body LIKE :keyword",
            keyword: "%#{@keyword}%"
          )
      

      when "user"
        if @match_type == "perfect"
        @users = User.where(
          handle_name: @keyword)
        else
          @users = User.where(
            "handle_name LIKE :keyword",
            keyword: "%#{@keyword}%"
          )
        end
      end
    end
  end


