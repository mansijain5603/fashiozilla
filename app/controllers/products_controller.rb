class ProductsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	  def index
	  	if params[:size].present?
	  		@products = Product.where(size: params[:size])
	    elsif params[:group_id].present?
	    	@group = Group.find_by(id: params[:group_id])
	    	@products = @group.products
	    else
	    	@products = Product.all
	    	#@order_item = current_order.order_items.new
		end

	  end

	  def show
	    @product = Product.find(params[:id])
	  end

	  def new
	    @product = Product.new
	  end
	  
	  def create
	    @product = current_user.products.new(product_params)
	    if @product.save
	      redirect_to products_path
	    else
	      render :new
	    end
	  end

	  def edit
	  	@product = Product.find(params[:id])
	  end

	  def update
	    @product = Product.find(params[:id])
	    if @product.update(product_params)
	      redirect_to @product
	    else
	      render :new
	    end
	  end

	  def destroy
	    @product = Product.find(params[:id])
	    @product.destroy

	    	redirect_to root_path
	  end

	  def all_cart_items
  	end
  	
	  private
	  def product_params
	    params.require(:product).permit(:group_id, :Name, :brand, :price, :size, :details, :category, images:[])
	  end
 end