class Repertoire < ApplicationRecord
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user

  with_options presence: true do
    validates :image
    validates :name, length: {maximum: 40}
    validates :time, length: {maximum: 3}
    validates :recipe
    validates :comment
  end

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank" }


end
