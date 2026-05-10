# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ShippingMethod.find_or_create_by!(name: "Standard Shipping")  { |s| s.price = 5.00  }
ShippingMethod.find_or_create_by!(name: "Express Shipping")   { |s| s.price = 12.00 }
ShippingMethod.find_or_create_by!(name: "Free Shipping")      { |s| s.price = 0.00  }

store = Store.first

3.times do |i|
  Customer.create!(
    first_name: "Customer#{i + 1}",
    last_name: "Test",
    email: "customer#{i + 1}@example.com",
    phone: "030000000#{i + 1}",
    city: "Mianwali",
    country: "Pakistan",
    postal_code: "42200",
    address: "Street #{i + 1}",
    company: "Demo Company",
    language: "en",
    is_default: i == 0,   # first customer = default
    store: store
  )
end