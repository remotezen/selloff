require "test_helper"

class ProductsControllerTest < ActionController::TestCase
  context 'GET #index' do
    setup{
      @user = users(:one)
      sign_in(@user)
      get :index

    }
    should respond_with 200
    should render_template 'index'
  end

end
