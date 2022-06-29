class CookingHack < ApplicationRecord
  belongs_to :user
  has_many :like_hacks
  has_many :liked_users, through: :like_hacks, source: :user
  has_one_attached :hack_image

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :contents
    validates :hack_image
  end

  def previous
    CookingHack.where('id < ?', id).order('id DESC').first
  end

  def next
    CookingHack.where('id > ?', id).order('id ASC').first
  end
end
