class RepertoiresController < ApplicationController
  
  def index
    @repertoires = Repertoire.includes(:user)
    @repertoires = Repertoire.order("created_at DESC")
  end
end


private

def repertoire_params
  params.require(:repertoire).permit(:image, :name, :time, :recipe, :commnt, :category_id, :user_id).merge(user_id: current_user.id)
end