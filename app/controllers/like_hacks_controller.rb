class LikeHacksController < ApplicationController
  class LikesController < ApplicationController
    def create
      @like_hack = current_user.like_hacks.create(cooking_hack_id: params[:cooking_hack_id])
      redirect_back(fallback_location: root_path)
    end
  
    def destroy
      @like_hack = LikeHack.find_by(cooking_hack_id: params[:cooking_hack_id], user_id: current_user.id)
      @like_hack.destroy
      redirect_back(fallback_location: root_path)
    end
  end
end
