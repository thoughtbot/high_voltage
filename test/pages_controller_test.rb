require 'test_helper'

class HighVoltage::PagesControllerTest < ActionController::TestCase
  context "on GET to /pages/exists" do
    setup do
      get :show, :id => 'exists'
    end

    should respond_with(:success)
    should render_template('exists')
  end

  context "on GET to /pages/invalid" do
    setup { get :show, :id => "invalid" }
    should respond_with(:missing)
  end
end
