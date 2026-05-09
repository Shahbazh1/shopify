class Product < ApplicationRecord
  belongs_to :store

  has_many :product_images, dependent: :destroy
  has_many :product_variants, dependent: :destroy

  has_many :product_collections, dependent: :destroy
  has_many :collections, through: :product_collections

  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  has_many :product_discounts, dependent: :destroy
  has_many :discounts, through: :product_discounts

  accepts_nested_attributes_for :product_variants, allow_destroy: true
  accepts_nested_attributes_for :product_images, allow_destroy: true

  before_validation :generate_slug

  validates :slug, presence: true, uniqueness: true

  private

  def generate_slug
    return if title.blank?
    self.slug = title.parameterize
  end
end