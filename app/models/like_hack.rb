class LikeHack < ApplicationRecord
  belongs_to :user
  belongs_to :cooking_hack

  validates_uniqueness_of :cooking_hack_id, scope: :user_id
end
