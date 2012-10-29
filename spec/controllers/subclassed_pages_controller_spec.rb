require 'spec_helper'

describe SubclassedPagesController do
  render_views

  describe 'on GET to /subclassed_pages/also_exists' do
    before { get :show, :id => 'also_exists' }

    it 'should respond with success and render template' do
      response.should be_success
      response.should render_template('also_exists')
    end

    it 'should use the custom configured layout' do
      response.should_not render_template('layouts/application')
      response.should render_template('layouts/alternate')
    end
  end

  it 'should raise a routing error for an invalid page' do
    lambda {
      get :show,
      :id => 'invalid'
    }.should raise_error(ActionController::RoutingError)
  end

  it 'should raise a routing error for a page in another directory' do
    lambda {
      get :show,
      :id => '../other/wrong'
    }.should raise_error(ActionController::RoutingError)
  end

  it 'should raise missing template error for valid page with invalid partial' do
    lambda {
      get :show,
      :id => 'also_exists_but_references_nonexistent_partial'
    }.should raise_error(ActionView::MissingTemplate)
  end
end
