class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
	if !session[:user]
		redirect_to collections_path, :alert=>"You have to log in to create a new collection"
	else
		@collection = Collection.new
	end
  end

  # GET /collections/1/edit
  def edit
	@collection = Collection.find(params[:id])
	if @collection.user.name != session[:user]
		redirect_to collection_path, :alert => "You cannot edit another user’s collection!"
	else
		@collection = Collection.find(params[:id])
	end
end
  
 

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
	@collection.user = User.find_by name: session[:user]

    
      if @collection.save
        redirect_to @collection, notice: 'Collection was successfully created.' 
      else
        render 'new'
      end
    end


  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to collections_path, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
	if @collection.user !=session[:user]
		redirect_to tweets_path,:alert => "You cannot delete another user's collection"
	else
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
	end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:title,:user_id)
    end
end
