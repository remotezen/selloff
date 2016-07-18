require "test_helper"

class BidsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)
    @higher_bid = @bid_one.bidded + 1
  end

  context 'should not display #show for non-logged in user' do
    setup{
      get :show, id: @product
    }
      should respond_with 302
  end
  context 'should get show' do
    setup{
      sign_in(@user)
      get :show, id: @product, xhr: true

    }
    should respond_with 200
  end
  context 'should create a new bid do' do
    setup{
      sign_in(@user)
      @higher_bid  = @bid_one.bidded + 1
      assert_difference 'Bid.count', 1 do
        post :create, bid:{user_id: @user, product_id: @product.id, bidded: @higher_bid}
      end
    }
    should respond_with 302
    should redirect_to("GET /products/index"){product_path(@product)}
    should set_flash
   end

  context 'should not create a  bid do for a non-signed in user' do
    setup{
      assert_no_difference 'Bid.count' do
        post :create, bid:{user_id: @user, product_id: @product, bidded: @higher_bid}
      end
    }
    should respond_with 302
    should redirect_to("GET /users/sign_in"){new_user_session_path}
    should set_flash
   end

end
