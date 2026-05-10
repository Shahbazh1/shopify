class InventoriesController < ApplicationController
  before_action :set_store

  def index
    @variants = ProductVariant
                  .includes(:product)
                  .where(products: { store_id: @store.id })
                  .references(:product)
  end

  def show
    @variant = ProductVariant.find(params[:id])
  end

  def edit
    @variant = ProductVariant.find(params[:id])
  end

  def update
    @variant = ProductVariant.find(params[:id])

    if @variant.update(inventory_params)
      redirect_to inventories_path(@store),
                  notice: "Inventory updated successfully."
    else
      render :edit
    end
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def inventory_params
    params.require(:product_variant)
          .permit(:stock_quantity)
  end
end