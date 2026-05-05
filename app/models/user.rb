class User < ApplicationRecord
  has_many :stores, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

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
