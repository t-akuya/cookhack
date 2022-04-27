class Ingredient < ApplicationRecord
  belongs_to :repertoire

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :serving

with_options presence: true do 
  validates :name
  validates :amount
end

validates :serving_id, numericality: { other_than: 1 , message: "が選択されていません" }



end
