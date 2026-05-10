class SegmentsController < ApplicationController

  def index
    @segments = Segment.all
  end

  def show
    @segment = Segment.find(params[:id])

    @customers = filter_customers(@segment)
  end

  private

  def filter_customers(segment)
    case segment.rule_type

    when "email"
      Customer.where.not(email: [nil, ""])

    when "orders_count"

      if segment.rule_value == "=0"
        Customer.where.not(email: [nil, ""])

      elsif segment.rule_value == ">=1"
        Customer.where("orders_count >= 1")
      end

    else
      Customer.all
    end
  end

end