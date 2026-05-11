class InventoriesController < ApplicationController
  include StoreFinder

  before_action :set_variant, only: [:show, :edit, :update]

  def index
    @variants = Inventories::VariantsListQuery.new(@store).call
  end

  def show
  end

  def edit
  end

  def update
    result = Inventories::UpdateService.new(
      @variant,
      inventory_params
    ).call

    if result[:success]
      redirect_to inventories_path(@store),
                  notice: "Inventory updated successfully."
    else
      render :edit
    end
  end

  private

  def set_variant
    @variant = ProductVariant.find(params[:id])
  end

  def inventory_params
    params.require(:product_variant)
          .permit(:stock_quantity)
  end
end