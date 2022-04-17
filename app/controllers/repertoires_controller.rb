class RepertoiresController < ApplicationController
  
  def index
    @repertoires = Repertoire.includes(:user)
  end
end