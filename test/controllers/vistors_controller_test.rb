require 'test_helper'

class VisitorsControllerTest < ActionController::TestCase
  context 'GET # index' do
    setup{
      get :index

    }
    should respond_with 200
    should render_template 'index'
  end

end

