class Admin::EndingsController < Admin::ApplicationController

  
  def show
    @ending = Ending.find(params[:id])
    @user = @ending.user
  end

end
