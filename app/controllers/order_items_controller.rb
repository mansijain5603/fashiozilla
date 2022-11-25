class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[show edit]
  def index
      @order_items = current_user.order.order_items
      @order_item = OrderItem.new
  end

  def new
      @order_item = OrderItem.new
  end 

  def implement
      @order_items = current_user.order.order_items
      @product = Product.find(params[:id])
      @order_item = current_user.order.order_items.create(product: @product)
      respond_to do |format|
          if @order_item.save
              format.js
          end
      end
  end

  def edit
  end

  def update
      @order_item.update(order_items_params)
      respond_to do |format|
          if @order_item.update
              format.js
          
          end
      end
  end

  def destroy
      respond_to do |format|
          if @order_item.delete
              format.js
          end
      end  
  end

  def add_product(product)
    if order_product = self.order_products.find_by_product_id(product.id)
      order_product.quantity += 1
      order_product.save
      order_products
    else
      self.order_products.create(:product_id => product.id, :quantity => 1)
    end
  end

  private

  def order_items_params
      params.require(:order_items).permit(:quantity, :product_id)
  end

  def set_order
      # @order_item = OrderItem.find(params[:id])
      #$order_item_id = $order_item [0][order_item_id]
  end


end
