class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

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
      item = user.items.find(params[:id])
    else
      item = Item.find(params[:id])
    end
    render json: item, include: :user
  end

  def create
    #if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
      render json: item, status: :created
     # else 
      #render json: :render_not_found_response
  end

  private
  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

  def item_params
    params.permit(:user_id, :name, :description, :price)
  end

end
