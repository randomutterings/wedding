class GiftsController < ApplicationController
  before_filter :authorize, :except => [:index, :create]
  protect_from_forgery :only => [:update, :destroy]
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
    @page = Page.find_by_permalink("gifts")
    if @percentage_collected > 99
      @height = 300
      @margin_top = 0
    end
  end
  
  def new
    @gift = Gift.new
  end
  
  def create
    # if txn_id is nil then the payment form was submitted, process normally
    if params[:txn_id].nil?
      @gift = Gift.new(params[:gift])
      if @gift.save
        flash[:notice] = "Thank you for your gift!"
        redirect_to gifts_url
      else
        render :action => 'new'
      end
    # else the payment was posted from paypal
    else
      # process the PayPal IPN POST and use the POSTed information to create a call back URL to PayPal
      query = 'cmd=_notify-validate'
      params.each_pair {|key, value| query = query + '&' + key + '=' + value unless key == "controller" || key == "action" || key == "commit"}
      begin
        http = Net::HTTP.start(APP_CONFIG['paypal_verification_url'], 443)
        http.use_ssl = true
        response = http.post(APP_CONFIG['paypal_verification_post'], query)
        http.finish
      rescue Net::HTTPError
        logger.error { "HTTP Error verifying payment from paypal, txn_id = #{@gift.txn_id}" }
      end
      # values from Paypal
      @gift = Gift.new
      @gift.name = "#{params[:first_name]} #{params[:last_name]}"
      @gift.amount = params[:mc_gross]
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
      if response.body.chomp == 'INVALID'
        flash[:error] = "There was a problem verifying your gift."
        redirect_to gifts_url
      elsif response.body.chomp == "CONFIRMED"
        if @gift.save
          flash[:notice] = "Thank you for your gift!"
          redirect_to gifts_url
        else
          render :action => 'new'
        end
      else
        logger.error { "paypal post - #{query}"}
        logger.error { "paypal error - #{response.body}" }
        flash[:error] = "There was a problem connecting to paypal to record your gift.  We will correct it shortly."
        redirect_to gifts_url
      end
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
