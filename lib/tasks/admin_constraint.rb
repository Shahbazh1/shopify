# lib/admin_constraint.rb

class AdminConstraint
  def self.matches?(request)
    user = request.env["warden"]&.user(:user)

    user&.role == "admin"
  end
end

# lib/admin_constraint.rb
# class AdminConstraint
#   def self.matches?(request)
#     return false unless request.session[:user_id] || 
#                         request.env["warden"]&.authenticated?(:user)
    
#     user = User.find_by(id: request.env["warden"]&.user(:user)&.id)
#     user&.admin?
#   end
# end