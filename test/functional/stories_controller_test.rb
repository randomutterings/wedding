require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Story.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Story.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Story.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to story_url(assigns(:story))
  end
  
  def test_edit
    get :edit, :id => Story.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Story.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Story.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Story.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Story.first
    assert_redirected_to story_url(assigns(:story))
  end
  
  def test_destroy
    story = Story.first
    delete :destroy, :id => story
    assert_redirected_to stories_url
    assert !Story.exists?(story.id)
  end
end
