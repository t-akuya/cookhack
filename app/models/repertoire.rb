class Repertoire < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :cooking_time
  belongs_to :serving

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :recipe
    validates :comment
  end

  with_options numericality:
   { other_than: 1, message: 'が選択されていません' } do
    validates :category_id
    validates :serving_id
    validates :cooking_time_id
  end

  def self.search(search)
    if search != ''
      Repertoire.includes(:ingredients).where(['repertoires.name LIKE ? OR ingredients.name LIKE ? OR ingredients.conversion_name LIKE ?',
                                               "%#{search}%", "%#{search}%", "%#{search}%"]).references(:ingredient)
    else
      Repertoire.all
    end
  end

  def previous
    Repertoire.where('id < ?', id).order('id DESC').first
  end

  def next
    Repertoire.where('id > ?', id).order('id ASC').first
  end
end
