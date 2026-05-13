# app/helpers/orders_helper.rb
module OrdersHelper
  def order_timeline(order)
    steps = [
      { label: "Order Placed",      done: true },
      { label: "Payment Confirmed", done: order.payment_status == "paid" },
      { label: "Order Confirmed",   done: order.order_status == "confirmed" || order.order_status == "completed" },
      { label: "Shipped",           done: ["shipped", "delivered"].include?(order.fulfillment_status) },
      { label: "Delivered",         done: order.fulfillment_status == "delivered" }
    ]

    reached_pending = false
    steps.map do |step|
      reached_pending = true unless step[:done]
      { label: step[:label], status: reached_pending ? "pending" : "done" }
    end
  end

  def fulfillment_badge_class(status)
    case status
    when "delivered" then "done"
    when "shipped"   then "shipped"
    else                  "pending"
    end
  end
end