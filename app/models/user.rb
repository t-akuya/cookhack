class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :first_name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ }
    validates :last_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ } 
    validates :first_name_kana, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
    validates :last_name_kana,  format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
    validates :birth_day
  end

  validates :password,          format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}

  has_many :repertoires


end
