class OrdersController < ApplicationController
    def index
      @order = OrderForm.new
      @item = Item.find(params[:item_id])
    end
   
    def create
      @order = OrderForm.new(order_params)
      @item = Item.find(params[:item_id])
       if @order.valid?
          @order.save
         redirect_to root_path
       else
         render :index
       end
    end
   
    private
    def order_params
     params.require(:order_form).permit(:postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number).merge(user_id:current_user.id, item_id: params[:item_id])
    end
end
