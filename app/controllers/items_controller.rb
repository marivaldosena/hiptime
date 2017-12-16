class ItemsController < ApplicationController
  before_action :find_item, only: %w[show edit update destroy]

  def index
    if user_signed_in?
      @items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def show
    # show
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
    # edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render :show
    end
  end

  private

  def find_item
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :index, notice: 'Item not found'
    end
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end