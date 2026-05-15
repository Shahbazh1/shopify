class Store < ApplicationRecord
  before_validation :generate_slug_and_domain
  validates :slug, presence: true, uniqueness: true
  
  belongs_to :owner,
             class_name: "User",
             foreign_key: :user_id

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :draft_orders, dependent: :destroy


  def generate_slug_and_domain
    return if name.blank?

    self.slug = name.parameterize
    self.domain = "#{slug}.myshop.com"
  end
end