class RepertoiresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @repertoires = Repertoire.includes(:user).order('created_at DESC')
    @cooking_hacks = CookingHack.includes(:user).order('created_at DESC')
  end

  def new
    @repertoire = Repertoire.new
    @ingredient = @repertoire.ingredients.build
  end

  def create
    @repertoire = Repertoire.new(repertoire_params)
    @ingredient = @repertoire.ingredients

    @ingredient.each do |ingredient|
      ingredient.conversion_name = 
        begin
          # 材料名がカタカナ、もしくはひらがなの場合、ローマ字に変換、左辺に代入
          if ingredient.name.match?(/\p{Han}/)
            ingredient.name.to_kanhira.to_roman
          # 材料名が漢字の場合、ひらがなに変換→さらにローマ字変換し、左辺に代入
          elsif ingredient.name.is_hira? || ingredient.name.is_kana?
            ingredient.name.to_roman
          # 漢字が含まれる場合そのまま代入
          elsif ingredient.name
            ingredient.name.to_kanhira.to_roman
          # どちらでもない場合ローマ字と判断、そのまま代入
          else
            ingredient.name
          end
        # 変換できなかった場合、そのまま代入
        rescue StandardError
          ingredient.name
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
    redirect_to root_path if @repertoire.user_id != current_user.id
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
    @repertoire.destroy if @repertoire.user_id == current_user.id
    redirect_to root_path
  end

  def search
    keyword = params[:keyword]
    unless keyword.blank?
      word = keyword
      conversion_word = if keyword.match?(/\p{Han}/)
                          keyword.to_kanhira.to_roman
                        elsif keyword.is_hira? || keyword.is_kana?
                          keyword.to_roman
                        else
                          keyword
                        end
    end
    @words = Repertoire.search(word)
    @search_words = Repertoire.search(conversion_word)
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
