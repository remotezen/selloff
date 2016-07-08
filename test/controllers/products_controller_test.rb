require "test_helper"

class ProductsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:one)
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)
  end
  context 'GET #index' do
    setup{
      sign_in(@user)
      get :index

    }
    should respond_with 200
    should render_template 'index'
  end
  context "should not create a product with if user not logged in" do
    setup{
      get :new
    }
      should respond_with 302 
  end
  context "should be able to access new product page proper credentials" do
    setup {
      sign_in(@user)
      get :new
    }
    should respond_with 200
  end
  
  context "should not create a product if not logged in" do
    setup{
    assert_no_difference 'Product.count' do   
    post :create,  product:{ name: "shiney new",
                                         description: "shiney new product",
                                         image: "shiney_new.jpg",
                                         category: "miscellanious",
                                         user_id: @user

      }
    end
    }
    should respond_with 302
  end
  context "should create a product if logged in" do
    setup{
     sign_in(@user)
     image = fixture_file_upload('images/purple_watch.jpeg', 'image/jpg')
      assert_difference 'Product.count' do   
      post :create, id: @user, product:{ name: "shiney new",
                                           description: "shiney new product",
                                           image: image,
                                           category: "miscellanious",

        }
      end

    }
    should set_flash
    should  respond_with 302 
  end

end
