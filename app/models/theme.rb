class Theme < ApplicationRecord
  belongs_to :store
  
  validates :name, presence: true
  validates :store_id, presence: true
  
  scope :active, -> { where(active: true) }
  
  def apply_to_store
    # Deactivate other themes for this store
    self.class.where(store_id: store_id).update_all(active: false)
    # Activate this theme
    update(active: true)
  end
end
