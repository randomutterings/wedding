class GiftsController < ApplicationController
  
  def index
    @gifts = Gift.all
  end
  
  def new
    @gift = Gift.new
  end
  
  def create
    @gift = Gift.new(params[:gift])
    if @gift.save
      flash[:notice] = "Successfully created gift."
      redirect_to gifts_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    flash[:notice] = "Successfully destroyed gift."
    redirect_to gifts_url
  end
end
