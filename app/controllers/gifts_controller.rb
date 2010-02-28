class GiftsController < ApplicationController
  
  def index
    @gifts = Gift.all
    total_in_cents = @gifts.map(&:amount).sum
    @total = total_in_cents.to_r.to_d / 100
    goal_in_cents = 500000
    @goal = goal_in_cents.to_r.to_d / 100
    @height = (((total_in_cents * 100) / goal_in_cents) * 300) / 100
    @margin_top = 300 - @height.to_i
    @percentage_collected = (total_in_cents * 100) / goal_in_cents
    @goal_left = (goal_in_cents - total_in_cents) / 100
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
  
  def edit
    @gift = Gift.find(params[:id])
  end
  
  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(params[:gift])
      flash[:notice] = "Successfully updated gift."
      redirect_to gifts_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    flash[:notice] = "Successfully destroyed gift."
    redirect_to gifts_url
  end
end
