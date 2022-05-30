class Ingredient < ApplicationRecord
  belongs_to :repertoire

  with_options presence: true do 
    validates :name
    validates :amount
  end



end
