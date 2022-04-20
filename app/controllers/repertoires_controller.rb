class RepertoiresController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  
  def index
    @repertoires = Repertoire.includes(:user)
    @repertoires = Repertoire.order("created_at DESC")
  end

  def new
    @repertoire = Repertoire.new
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
    @repertoire = Repertoire.find(params[:id])
  end


end


private

def repertoire_params
  params.require(:repertoire).permit(:image, :name, :cooking_time_id, :category_id, :recipe, :comment, :user_id).merge(user_id: current_user.id)
end