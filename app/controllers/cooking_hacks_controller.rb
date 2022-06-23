class CookingHacksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_action, only: [:show, :edit, :update]

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
  end

  def edit
  end


  def update
    if @cooking_hack.update(cooking_hack_params)
      redirect_to cooking_hack_path
    else
      render :edit
    end
  end


  private
  def cooking_hack_params
    params.require(:cooking_hack)
    .permit(:hack_image, :title, :contents, :user_id)
    .merge(user_id: current_user.id)
  end

  def set_action
    @cooking_hack = CookingHack.find(params[:id])
  end

end
