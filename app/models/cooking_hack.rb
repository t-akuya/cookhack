class CookingHack < ApplicationRecord
  
  belongs_to :user
  has_many :likes
  has_one_attached :hack_image

  with_options presence: true do
    validates :title, length: {maximum: 40}
    validates :contents
    validates :hack_image
  end

  def previous
    CookingHack.where("id < ?", self.id).order("id DESC").first
  end

  def next
    CookingHack.where("id > ?", self.id).order("id ASC").first
  end

end
