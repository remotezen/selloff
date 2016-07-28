require "test_helper"

class ProductsControllerTest < ActionController::TestCase

  def setup
    @user = users(:one)
    @not_seller = users(:not_seller)
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)
    @wrong_seller = users(:wrong_seller)
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
                               category: "miscellanious",
                               expiration: "2015-02-29 10:30:19",

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
      post :create, id: @user, product:{   name: "shiney new",
                                           description: "shiney new product",
                                           category: "miscellanious",
                                           expiration: "2017-02-29 10:30:19",
                                           product_attachments:{image: image}

        }
      end

    }
    should set_flash
    should  respond_with 302
  end
  context "signed in user should  access new if not a seller" do
    setup{
      sign_in(@not_seller)
      get :new
    }
    should respond_with 302
  end

  context "signed  in seller should be able to  access new " do
    setup{
      sign_in(@user)
      get :new
    }
    should respond_with 200
  end
  context "seller should not be able to edit another sellers product" do
    setup{
      sign_in(@wrong_seller)
      sign_in(@user)
      image = fixture_file_upload('images/purple_watch.jpeg', 'image/jpg')
      patch :update, id: @user, product:{ name: "shiney new",
                                           description: "shiney new product",
                                           image: image,
                                           category: "miscellanious",
                                           expiration: Time.now()

        }
    }
    should redirect_to("Get /visitors/index") { root_path }
  end
  context "expiration date must be in the future" do
    setup{
      sign_in(@user)
      image = fixture_file_upload('images/purple_watch.jpeg', 'image/jpg')
      patch :update, id: @wrong_user, product:{ name: "shiney new",
                                           description: "shiney new product",
                                           image: image,
                                           category: "miscellanious",
                                           expiration: "2013-02-29 10:30:19"
        }
    }

  end
end

