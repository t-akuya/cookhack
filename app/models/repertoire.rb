class Repertoire < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :cooking_time

  with_options presence: true do
    validates :image
    validates :name, length: {maximum: 40}
    validates :recipe
    validates :comment
  end

  validates :category_id,     numericality: { other_than: 1 , message: "が選択されていません" }
  validates :cooking_time_id, numericality: { other_than: 1 , message: "が選択されていません" }


end
