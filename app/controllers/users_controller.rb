class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @repertoires = current_user.repertoires
    @cooking_hacks = current_user.cooking_hacks
  end

end

