require "test_helper"

class BidsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)
    @other_user = users(:not_seller)
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
  context 'should not allow less than incremental bid' do
    setup{
      sign_in @user
      @not_high_enough_bid = @higher_bid + 0.01
      post :create, bid:{user_id: @user, product_id: @product, bidded: @higher_bid}
      sign_out @user
      sign_in @other_user
      assert_no_difference 'Bid.count' do
        post :create, bid:{user_id: @other_user, product_id: @product, bidded: @not_high_enough_bid
        }
      end
    }
    should set_flash
    should redirect_to('GET products/index'){products_path}
  end
  context 'should not create bid without a product_id' do
    setup{
      sign_in @user
      assert_no_difference 'Bid.count' do
        post :create, bid:{user_id: @user, product_id: 0, bidded: @higher_bid}
      end
    }

    should redirect_to('GET products/index'){products_path}
  end
end

