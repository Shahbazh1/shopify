class CheckoutsController < StoreBaseController
  include StoreFinder

  def index
    @carts = Checkouts::CartsIndexQuery.new(@store).call
  end

  def show
    @cart = Checkouts::CartShowQuery.new(
      @store,
      params[:id]
    ).call
  end
end