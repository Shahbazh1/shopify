class ProductsController < ApplicationController
  include StoreFinder

  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = @store.products
  end

  def new
    @product = @store.products.new
    @product.product_variants.build
    @product.product_images.build
  end

  def show
  end

  def create
    result = Products::CreateService.new(@store, product_params).call

    @product = result[:product]

    if result[:success]
      redirect_to product_url(@store, @product),
                  notice: "Product created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    result = Products::UpdateService.new(@product, product_params).call

    @product = result[:product]

    if result[:success]
      redirect_to product_url(@store, @product),
                  notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = @store.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :category,
      :status,
      :published_online_store,
      :published_pos,
      product_variants_attributes: [
        :id,
        :color,
        :size,
        :price,
        :stock_quantity,
        :_destroy
      ],
      product_images_attributes: [
        :id,
        :image_url,
        :alt_text,
        :_destroy
      ]
    )
  end
end