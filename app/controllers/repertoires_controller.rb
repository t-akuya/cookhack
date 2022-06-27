class RepertoiresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @repertoires = Repertoire.includes(:user).order("created_at DESC")
    @cooking_hacks = CookingHack.all
  end

  def new
    @repertoire = Repertoire.new
    @ingredient = @repertoire.ingredients.build
  end

  def create
    @repertoire = Repertoire.new(repertoire_params)
    @ingredient = @repertoire.ingredients

    @ingredient.each do |ingredient|
       #材料名がカタカナ、もしくはひらがなの場合、ローマ字に変換、左辺に代入
      if ingredient.name.is_hira? || ingredient.name.is_kana?
        ingredient.conversion_name = ingredient.name.to_roman
        #材料名に漢字が含まれていれば、ひらがなに変換→さらにローマ字変換し、左辺に代入
      elsif ingredient.name.match?(/\p{Han}/)
        ingredient.conversion_name = ingredient.name.to_kanhira.to_roman
      else #どちらでもない場合、入力された材料名はそのまま代入
        ingredient.conversion_name = ingredient.name
      end
    end

    if @repertoire.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @like = Like.new
  end

  def edit
    if @repertoire.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    @repertoire.ingredients.destroy_all
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

  def search
    @repertoires = Repertoire.search(params[:keyword])
    keyword = params[:search]

    unless keyword.blank?
      if keyword.is_hira? || keyword.is_kana?
        conversion_keyword = keyword.to_roman
      elsif keyword.match?(/\p{Han}/)
        conversion_keyword = keyword.to_kanhira.to_roman
      else
        conversion_keyword = keyword
      end
    end
    
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
    :serving_id,
    :recipe,
    :comment,
    :user_id,

    ingredients_attributes: [:id, :name, :amount, :conversion_name, :_destroy]
    )
    .merge(user_id: current_user.id)
end

def set_action
  @repertoire = Repertoire.find(params[:id])
end