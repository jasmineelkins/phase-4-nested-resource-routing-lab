class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:item_id])
    else
      null
    end
    render json: item, include: :user
  end

  private

  def render_not_found
    render json: { error: 'User not found' }, status: :not_found
  end
end
