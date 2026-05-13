module Segments
  class CustomersQuery
    def initialize(segment)
      @segment = segment
    end

    def call
      case @segment.rule_type
      when "email"
        customers_with_email

      when "orders_count"
        customers_by_orders_count

      else
        Customer.all
      end
    end

    private

    def customers_with_email
      Customer.where.not(email: [nil, ""])
    end

    def customers_by_orders_count
      case @segment.rule_value

      when "=0"
        Customer
          .left_joins(:orders)
          .group("customers.id")
          .having("COUNT(orders.id) = 0")

      when ">=1"
        Customer
          .joins(:orders)
          .group("customers.id")
          .having("COUNT(orders.id) >= 1")

      else
        Customer.all
      end
    end
  end
end