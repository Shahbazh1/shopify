# app/controllers/admin/draft_orders_controller.rb
class DraftOrdersController < ApplicationController
  before_action :set_store
  before_action :set_draft_order, only: [:show, :edit, :update, :destroy, :send_invoice]

  def index
    @draft_orders = @store.draft_orders.order(created_at: :desc)
  end

  def new
    @products= @store.products
    @draft_order = @store.draft_orders.build
  end

  def create
    @draft_order = @store.draft_orders.build(draft_order_params)
    if @draft_order.save
      redirect_to draft_orders_path(@store), notice: 'Draft order was successfully created.'
    else
      render :new
    end
  end

  def show 
  end

  def edit
  end

  def update
  if @draft_order.update(draft_order_params)
    redirect_to edit_draft_order_path(@store, @draft_order),
    notice: "Draft order updated"
  else
    render :edit
  end
end

  def send_invoice
    DraftOrderMailer.invoice_email(@draft_order).deliver_later
    @draft_order.update(status: 'invoice_sent', invoice_sent_at: Time.current)
    render json: { success: true, message: 'Invoice sent successfully' }
  end

  def destroy
    @draft_order.destroy
    redirect_to admin_store_draft_orders_path(@store)
  end

  private

  def set_store
    @store = current_user.stores.find_by(id: params[:store_id])
  end

  def set_draft_order
    @draft_order = @store.draft_orders.find(params[:id])
  end

  def draft_order_params
    params.require(:draft_order).permit(
       :status,
      :subtotal,
       :discount_amount,
      :shipping_price,
       :total_price,
       
      draft_order_items_attributes: [
  :id,
  :product_id,
  :product_variant_id,
  :custom_title,
  :price,
  :quantity,
  :_destroy
]
    )
  end
end