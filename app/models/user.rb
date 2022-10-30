class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  has_many :events, foreign_key: :author_id
  validates :dni, allow_blank: true, format: { with: /\A[0-9]{1,2}(\.?[0-9]{3}){2}-[0-9+K]\z/ }
  validates :phone, allow_blank: true, format: { with: /\A\+[0-9]{2,3}\s[0-9]{8,15}\z/ }
end
