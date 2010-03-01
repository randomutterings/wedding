require 'test_helper'

class GuestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Guest.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Guest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Guest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to guest_url(assigns(:guest))
  end
  
  def test_edit
    get :edit, :id => Guest.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Guest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Guest.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Guest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Guest.first
    assert_redirected_to guest_url(assigns(:guest))
  end
  
  def test_destroy
    guest = Guest.first
    delete :destroy, :id => guest
    assert_redirected_to guests_url
    assert !Guest.exists?(guest.id)
  end
end
