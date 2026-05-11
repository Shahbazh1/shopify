class SegmentsController < ApplicationController
  def index
    @segments = Segment.all
  end

  def show
    @segment = Segment.find(params[:id])
    @customers = Segments::CustomersQuery.new(@segment).call
  end
end