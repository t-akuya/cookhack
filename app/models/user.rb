class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :repertoires
  has_many :cooking_hacks
  has_many :likes, dependent: :destroy
  has_many :like_hacks, dependent: :destroy
  has_many :liked_repertoires, through: :likes, source: :repertoire

  def already_liked?(repertoire)
    self.likes.exists?(repertoire_id: repertoire.id)
  end

  def already_hack_liked?(cooking_hack)
    self.like_hacks.exists?(cooking_hack_id: cooking_hack.id)
  end


  with_options presence: true do
    validates :nickname
    validates :first_name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ }
    validates :last_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ } 
    validates :first_name_kana, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
    validates :last_name_kana,  format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
    validates :birth_day
  end

  validates :password,          format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}

end
