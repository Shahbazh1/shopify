# lib/storefront_subdomain_constraint.rb

class StorefrontSubdomainConstraint
  def self.matches?(request)
    subdomain = request.subdomain
    
    # Must have a subdomain
    return false if subdomain.blank?
    
    # Exclude reserved subdomains
    excluded = %w[www admin api mail]
    return false if excluded.include?(subdomain)
    
    # Check it actually matches a real store in DB
    Store.exists?(slug: subdomain)
  end
end