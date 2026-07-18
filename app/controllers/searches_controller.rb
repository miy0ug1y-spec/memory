class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @search_type = params[:search_type]

    if @keyword.present?
      case @search_type
      when "post"
        @posts = Post.published.where(
          "title LIKE :keyword OR body LIKE :keyword",
          keyword: "%#{@keyword}%")
      when "user"
        @users = User.where(
         "handle_name LIKE :keyword",
          keyword: "%#{@keyword}%")
      end
    end
  end
end

