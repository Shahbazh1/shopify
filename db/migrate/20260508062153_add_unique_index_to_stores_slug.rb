# db/migrate/20260508XXXXXX_add_unique_index_to_stores_slug.rb
class AddUniqueIndexToStoresSlug < ActiveRecord::Migration[8.1]
  def change
    add_index :stores, :slug, unique: true
  end
end