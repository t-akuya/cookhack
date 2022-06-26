class Like < ApplicationRecord
  belongs_to :user
  belongs_to :repertoire

  validates_uniqueness_of :repertoire_id, scope: :user_id
end
