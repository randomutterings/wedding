require 'test_helper'

class GiftsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Gift.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Gift.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to gifts_url
  end
  
  def test_destroy
    gift = Gift.first
    delete :destroy, :id => gift
    assert_redirected_to gifts_url
    assert !Gift.exists?(gift.id)
  end
end
