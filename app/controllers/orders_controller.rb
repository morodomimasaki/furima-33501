class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.user_id == current_user.id || !@item.purchase.nil?
    @order = OrderForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order = OrderForm.new(order_params)
    @item = Item.find(params[:item_id])
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.selling_price,  # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
