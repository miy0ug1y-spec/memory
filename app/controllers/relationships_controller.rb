class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    Current.user.active_relationships.create(
      followed: user
    )

    redirect_to user_path(user)
  end

  def destroy
    relationship = Current.user.active_relationships.find(params[:id])

    relationship.destroy
    
    redirect_to user_path(relationship.followed)
  end

end
