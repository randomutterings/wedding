class StoriesController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  def index
    @stories = Story.all
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def new
    @story = Story.new
    @published_on = Date.today
  end
  
  def create
    @story = Story.new(params[:story])
    if @story.save
      flash[:notice] = "Successfully created story."
      redirect_to @story
    else
      render :action => 'new'
    end
  end
  
  def edit
    @story = Story.find(params[:id])
    @published_on = @story.published_on
  end
  
  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      flash[:notice] = "Successfully updated story."
      redirect_to @story
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:notice] = "Successfully destroyed story."
    redirect_to stories_url
  end
end
