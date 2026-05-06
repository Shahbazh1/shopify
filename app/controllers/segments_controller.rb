class SegmentsController < ApplicationController
  def index
  @segments = Customer.all || []
end

  def show
  end
end
