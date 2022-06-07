class CookingHacksController < ApplicationController
  def 
    @cooking_hacks = CookingHack.all
  end

end
