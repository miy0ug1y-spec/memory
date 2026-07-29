class Admin::EndingsController < ApplicationController

  def index
    @endings = Ending.includes(:user).order(created_at: :desc)
  end
  
  def show
    @ending = Ending.find(params[:id])
  end

end
