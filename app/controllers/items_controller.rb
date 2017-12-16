class ItemsController < ApplicationController
  before_action :find_item, only: %w[show edit update destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    # show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

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
      redirect_to @item
    else
      render :edit
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