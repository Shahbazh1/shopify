class Customer < ApplicationRecord
  belongs_to :store

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

end