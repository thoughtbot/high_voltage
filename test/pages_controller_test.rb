require 'test_helper'

class HighVoltage::PagesControllerTest < ActionController::TestCase

  context "on GET to /pages/exists" do
    setup do
      get :show, :id => 'exists'
    end

    should respond_with(:success)
    should render_template('exists')
  end

  should "raise a routing error for an invalid page" do
    assert_raise ActionController::RoutingError do
      get :show, :id => "invalid"
    end
  end

end
