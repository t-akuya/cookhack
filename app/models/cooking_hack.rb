class CookingHack < ApplicationRecord
  
  belongs_to :user
  has_one_attached :hack_image

  with_options presence: true do
    validates :title, length: {maximum: 40}
    validates :contents
    validates :hack_image
  end

end
