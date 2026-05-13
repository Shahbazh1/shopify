class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :store

  has_many :orders
  has_one :cart, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

end