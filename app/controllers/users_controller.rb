class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @repertoires = current_user.repertoires
    @cooking_hacks = current_user.cooking_hacks
    
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:repertoire_id)
    @like_repertoires = Repertoire.find(likes)
  end


end

