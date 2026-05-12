class CollectionsController < StoreBaseController
  include StoreFinder

  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collections::ListQuery.new(@store).call
  end

  def show
  end

  def new
    @collection = @store.collections.new
    @products = form_data[:products]
  end

  def create
    result = Collections::CreateService.new(
      @store,
      collection_params
    ).call

    @collection = result[:collection]

    if result[:success]
      redirect_to collections_path(@store),
                  notice: "Collection created successfully"
    else
      @products = form_data[:products]
      render :new
    end
  end

  def edit
    @products = form_data[:products]
  end

  def update
    result = Collections::UpdateService.new(
      @collection,
      collection_params
    ).call

    @collection = result[:collection]

    if result[:success]
      redirect_to collections_path(@store),
                  notice: "Collection updated successfully"
    else
      @products = form_data[:products]
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to store_collections_path(@store),
                notice: "Collection deleted"
  end

  private

  def set_collection
    @collection = @store.collections.find(params[:id])
  end

  def form_data
    Collections::FormDataQuery.new(@store).call
  end

  def collection_params
    params.require(:collection).permit(
      :title,
      :description,
      product_collections_attributes: [
        :id,
        :product_id,
        :_destroy
      ]
    )
  end
end