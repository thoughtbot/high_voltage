require 'test_helper'

class HighVoltage::PagesControllerTest < ActionController::TestCase

  context "on GET to /pages/exists" do
    setup do
      get :show, :id => 'exists'
    end

    should respond_with(:success)
    should render_template('exists')
  end

  context "on GET to /pages/dir/nested" do
    setup do
      get :show, :id => 'dir/nested'
    end

    should respond_with(:success)
    should render_template('pages/dir/nested')
  end
  
  context "on GET to /pages/exists with layout" do
    setup do
      get :show, :id => 'exists', :layout=>'application'
    end

    should respond_with(:success)
    should render_template('exists')
    should render_with_layout('application')
  end

  context "on GET to /pages/exists without layout" do
    setup do
      get :show, :id => 'exists', :layout=>false
    end

    should respond_with(:success)
    should render_template('exists')
    should_not render_with_layout
  end

  should "raise a routing error for an invalid page" do
    assert_raise ActionController::RoutingError do
      get :show, :id => "invalid"
    end
  end

  should "raise a routing error for a page in another directory" do
    assert_raise ActionController::RoutingError do
      get :show, :id => "../other/wrong"
    end
  end

  should "raise missing template error for valid page with invalid partial" do
    assert_raise ActionView::MissingTemplate do
      get :show, :id => "exists_but_references_nonexistent_partial"
    end
  end
end
