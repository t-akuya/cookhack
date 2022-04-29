class RepertoiresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @repertoires = Repertoire.includes(:user)
    @repertoires = Repertoire.order("created_at DESC")
  end

  def new
    @repertoire = Repertoire.new
    @repertoire.ingredients.build
  end

  def create
    @repertoire = Repertoire.new(repertoire_params)
      if @repertoire.save
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def edit
    if @repertoire.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    if @repertoire.update(repertoire_params)
      redirect_to repertoire_path
    else
      render :edit
    end
  end

  def destroy
    if @repertoire.user_id == current_user.id
      @repertoire.destroy
    end
    redirect_to root_path
  end

end


private

def repertoire_params
  params.require(:repertoire)
  .permit(
    :image,
    :name,
    :cooking_time_id,
    :category_id,
    :recipe,
    :comment,
    :user_id,
    ingredients_attributes: [:id, :serving_id, :name, :amount, :_destroy]
    )
    .merge(user_id: current_user.id)
end

def set_action
  @repertoire = Repertoire.find(params[:id])
end