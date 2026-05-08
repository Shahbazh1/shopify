class Store < ApplicationRecord
  belongs_to :user

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :discounts, dependent: :destroy

  before_validation :generate_slug_and_domain

  def generate_slug_and_domain
    return if name.blank?

    self.slug = name.parameterize
    self.domain = "#{slug}.myshop.com"
  end
end