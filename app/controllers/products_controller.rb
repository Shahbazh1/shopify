class ProductsController < ApplicationController
  before_action :set_user_store
  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = @store.products
  end

  def new
    @product = @store.products.new
    @product.product_variants.build
    @product.product_images.build
  end

  def show; end
  def edit; end

  def create
    @product = @store.products.new(product_params)

    if @product.save
      redirect_to edit_product_path(@store, @product), notice: "Product created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_store
    @user = User.first
    @store = current_user.stores.find_by(id: params[:store_id])

    redirect_to root_path, alert: "Store not found" unless @store
  end

  def set_product
    @product = @store.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :category,
      :price,
      :inventory_quantity,
      :status,
      :published_online_store,
      :published_pos,
      product_variants_attributes: [:id, :color, :size, :price, :stock_quantity, :_destroy],
      product_images_attributes: [:id, :image_url, :alt_text, :_destroy]
    )
  end
end