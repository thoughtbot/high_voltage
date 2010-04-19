require 'test_helper'

class HighVoltage::PagesControllerTest < ActionController::TestCase

  context "on GET to /pages/exists" do
    setup do
      get :show, :id => 'exists'
    end

    should_respond_with :success
    should_render_template 'exists'
  end

  context "on GET to /pages/invalid" do
    setup { get :show, :id => "invalid" }
    should_respond_with :missing
  end

end
