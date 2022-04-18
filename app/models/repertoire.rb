class Repertoire < ApplicationRecord
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: ture do
    validates :image
    validates :name, length: {maximum: 40}
    validates :time
    validates :recipe
    validates :comment
    validates :category_id, numericality: { other_than: 1 , message: "can't be blank" }
  end



end
