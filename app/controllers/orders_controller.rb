class OrdersController < ApplicationController
  def show
        @order = Order.find(params[:id])
    end

    def destroy
         @order = Order.find(params[:id])
         if @order.destroy
            redirect_to root_path
    end
end
