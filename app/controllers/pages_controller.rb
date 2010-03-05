class PagesController < ApplicationController
  before_filter :authorize, :except => :show
  def index
    @pages = Page.all
  end
  
  def show
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, "Page not found" if @page.nil? || @page.permalink == "gifts"
    else
      @page = Page.find(params[:id])
    end
    render :partial => "home", :layout => "application" if params[:permalink] == 'home'
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      if @page.permalink == "home"
        redirect_to root_url
      elsif @page.permalink == "gifts"
        redirect_to gifts_url
      else
        redirect_to @page
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
end
