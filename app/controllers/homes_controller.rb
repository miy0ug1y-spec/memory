class HomesController < ApplicationController
  allow_unauthenticated_access only: [:top, :about]

  def top
    @genres = Genre.includes(posts: [:user, image_attachment: :blob]).order(:id)

  end

  def about
  end

end
