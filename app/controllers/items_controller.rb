class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :uretara_hennsyuudekinai, only: [:edit]


  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  # def destroy
  #   item = Item.find(params[:id])
  #   item.destroy
  # end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :product_description, :category_id, :product_condition_id,:product_condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id, :selling_price).merge(user_id: current_user.id)
  end

  def uretara_hennsyuudekinai
    redirect_to root_path unless current_user
  end
end
