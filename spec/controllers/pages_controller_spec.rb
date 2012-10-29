# encoding: UTF-8
require 'spec_helper'

describe HighVoltage::PagesController do
  render_views

  context 'using default configuration' do
    describe 'on GET to /pages/exists' do
      before { get :show, :id => 'exists' }

      it 'should respond with success and render template' do
        response.should be_success
        response.should render_template('exists')
      end

      it 'should use the default layout used by ApplicationController' do
        response.should render_template('layouts/application')
      end
    end

    describe 'on GET to /pages/dir/nested' do
      before { get :show, :id => 'dir/nested' }

      it 'should respond with success and render template' do
        response.should be_success
        response.should render_template('pages/dir/nested')
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
        :id => 'exists_but_references_nonexistent_partial'
      }.should raise_error(ActionView::MissingTemplate)
    end
  end

  context 'using custom layout' do
    before(:all) do
      @original_layout = HighVoltage.layout
      HighVoltage.layout = 'alternate'
    end

    after(:all) do
      HighVoltage.layout = @original_layout
    end

    describe 'on GET to /pages/exists' do
      before { get :show, :id => 'exists' }

      it 'should use the custom configured layout' do
        response.should_not render_template('layouts/application')
        response.should render_template('layouts/alternate')
      end
    end
  end

  context 'using custom content path' do
    before(:all) do
      @original_content_path = HighVoltage.content_path
      HighVoltage.content_path = 'other_pages/'
    end

    after(:all) do
      HighVoltage.content_path = @original_content_path
    end

    describe 'on GET to /other_pages/also_exists' do
      before { get :show, :id => 'also_exists' }

      it 'should respond with success and render template' do
        response.should be_success
        response.should render_template('other_pages/also_exists')
      end
    end

    describe 'on GET to /other_pages/also_dir/nested' do
      before { get :show, :id => 'also_dir/also_nested' }

      it 'should respond with success and render template' do
        response.should be_success
        response.should render_template('other_pages/also_dir/also_nested')
      end
    end

    it 'should raise a routing error for an invalid page' do
      lambda { 
        get :show, 
        :id => 'also_invalid' 
      }.should raise_error(ActionController::RoutingError)
    end

    it 'should raise a routing error for a page in another directory' do
      lambda {
        get :show,
        :id => '../other/wrong' 
      }.should raise_error(ActionController::RoutingError)
    end

    it 'should raise a routing error for a page in another directory when using a Unicode exploit' do
      lambda { 
        get :show,
        :id => '/\\../other/wrong'
      }.should raise_error(ActionController::RoutingError)
    end

    it 'should raise missing template error for valid page with invalid partial' do
      lambda {
        get :show,
        :id => 'also_exists_but_references_nonexistent_partial'
      }.should raise_error(ActionView::MissingTemplate)
    end
  end
end
