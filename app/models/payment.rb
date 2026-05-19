class Payment < ApplicationRecord
  belongs_to :order
end

# here there is no need of direct relationship of payment with the customer and store as through order we can access both customer and store. This keeps the model simpler and avoids unnecessary associations. also in the store and customer i have add the association like through order we can access payment. this way we can keep the code cleaner and more maintainable.