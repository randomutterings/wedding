class GiftsController < ApplicationController
  before_filter :authorize, :except => [:index, :create]
  protect_from_forgery :only => [:update, :destroy]
  def index
    @gifts = Gift.all
    @page = Page.find_by_permalink("gifts")
  end
  
  def show
    @gift = Gift.find(params[:id])
  end
  
  def new
    @gift = Gift.new
  end
  
  def create
    # if txn_id is nil then the payment form was submitted, process normally
    if params[:txn_id].nil?
      params[:gift][:amount] = (params[:gift][:amount].to_f * 100) unless (params[:gift][:amount] =~ /\./).nil?
      @gift = Gift.new(params[:gift])     
    # else the payment was posted from paypal
    else
      @gift = Gift.new
      @gift.name = "#{params[:first_name]} #{params[:last_name]}"
      @gift.amount = (params[:mc_gross].to_r.to_d * 100).to_i
      @gift.status = params[:payment_status]
      @gift.txn_id = params[:txn_id]
      @gift.receiver_email = params[:receiver_email]
      @gift.payer_email = params[:payer_email]
      @gift.address_city = params[:address_city]
      @gift.address_country = params[:address_country]
      @gift.address_name = params[:address_name]
      @gift.address_state = params[:address_state]
      @gift.address_status = params[:address_status]
      @gift.address_street = params[:address_street]
      @gift.address_zip = params[:address_zip]
    end
    if @gift.save
      flash[:notice] = "Thank you for your gift!"
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
