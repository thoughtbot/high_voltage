require 'spec_helper'

describe HighVoltage::PagesController do

  render_views

  describe"on GET to /pages/exists" do
    before { get :show, :id => 'exists' }

    it "should respond with success and render template" do
      response.should be_success
      response.should render_template('exists')
    end
  end

  describe "on GET to /pages/dir/nested" do
    before { get :show, :id => 'dir/nested' }

    it "should respond with success and render template" do
      response.should be_success
      response.should render_template('pages/dir/nested')
    end
  end

  it "should raise a routing error for an invalid page" do
    lambda { get :show, :id => "invalid" }.should raise_error(ActionController::RoutingError)
  end

  it "should raise a routing error for a page in another directory" do
    lambda { get :show, :id => "../other/wrong" }.should raise_error(ActionController::RoutingError)
  end

  it "should raise missing template error for valid page with invalid partial" do
    lambda { get :show, :id => "exists_but_references_nonexistent_partial" }.should raise_error(ActionView::MissingTemplate)
  end

end
