class Customer < ApplicationRecord
  belongs_to :store

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

end