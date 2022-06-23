class CookingHacksController < ApplicationController
  def index
    @cooking_hacks = CookingHack.all
  end

  def new
    @cooking_hack = CookingHack.new
  end

  def create
    @cooking_hack = CookingHack.new(cooking_hack_params)
    if @cooking_hack.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @cooking_hack = CookingHack.find(params[:id])
  end

  private
  def cooking_hack_params
    params.require(:cooking_hack)
    .permit(:hack_image, :title, :contents, :user_id)
    .merge(user_id: current_user.id)
  end

end
