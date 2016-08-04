class WatchesController < ApplicationController
  before_action :authenticate_user!
  def create
    watch = current_user.watches.build(product_id: params[:id])
    if watch.save
      redirect_to :back
    else
      flash[:info] = "There was an error watching this item"
      redirect_to :back
    end
  end

  def destroy
  end

  def index
    @watching = current_user.watches
  end
end
