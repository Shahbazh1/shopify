class DraftOrdersController < StoreBaseController
  include StoreFinder

  before_action :set_draft_order,
                only: [:show, :edit, :update, :destroy, :send_invoice]

  def index
    @draft_orders = DraftOrders::ListQuery.new(@store).call
  end

  def new
    @products = form_data.products
    @draft_order = @store.draft_orders.new
  end

  def create
    result = DraftOrders::CreateService.new(
      @store,
      draft_order_params,
      user: current_user
    ).call

    @draft_order = result[:draft_order]

    if result[:success]
      redirect_to edit_draft_order_path(@store, @draft_order),
                  notice: "Draft order was successfully created."
    else
      @products = form_data.products
      render :new
    end
  end

  def show
  end

  def edit
    @products = form_data.products
    @draft_order_items = form_data.items
    @draft_order = @store.draft_orders.find(params[:id])
  end

  def update
    result = DraftOrders::UpdateService.new(
      @draft_order,
      draft_order_params,
      user: current_user
    ).call

    if result[:success]
      redirect_to edit_draft_order_path(@store, @draft_order),
                  notice: "Draft order updated"
    else
      render :edit
    end
  end

 def send_invoice
  email   = params[:email]
  message = params[:message]

  DraftOrderMailer.invoice(@draft_order, email, message).deliver_now

  render json: { success: true, message: "Invoice sent successfully" }
end

  def destroy
    @draft_order.destroy
    redirect_to admin_store_draft_orders_path(@store)
  end

  private

  def set_draft_order
    @draft_order = @store.draft_orders.find(params[:id])
  end

  def form_data
    DraftOrders::FormDataQuery.new(@store, @draft_order)
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