class User < ApplicationRecord
  has_many :owned_stores,
         class_name: "Store",
         foreign_key: :user_id,
         dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :stores, through: :memberships
  has_many :draft_orders
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  enum :role, { user: "user", admin: "admin" }

  def self.from_omniauth(auth)

    user = where(email: auth.info.email).first_or_initialize
    user.provider ||= auth.provider
    user.uid ||= auth.uid

      if user.new_record?
        user.password = Devise.friendly_token[0, 20]
      end

    user.save
    user
  end
end
