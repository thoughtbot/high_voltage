require 'spec_helper'

describe 'routes' do
  context 'default configuration' do
    it 'generates a route' do
      page_path('one').should eq '/pages/one'
    end

    it 'generates a nested route' do
      page_path('one/two').should eq '/pages/one/two'
    end

    it 'recognizes a route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one'
        },
        '/pages/one'
      )
    end

    it 'recognizes a nested route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one/two'
        },
        '/pages/one/two'
      )
    end

    it 'recognizes a route with dots' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one.two.three'
        },
        '/pages/one.two.three'
      )
    end
  end

  context 'using top-level routing configuration' do
    before(:each) do
      HighVoltage.route_drawer = HighVoltage::RouteDrawers::Root
      Rails.application.reload_routes!
    end

    it 'generates a route' do
      page_path('one').should eq '/one'
    end

    it 'generates  a nested route' do
      page_path('one/two').should eq '/one/two'
    end
  end

  context 'custom content path' do
    before(:each) do
      HighVoltage.content_path = 'other_pages/'
      Rails.application.reload_routes!
    end

    it 'generates a route' do
      page_path('one').should eq '/other_pages/one'
    end

    it 'generates a nested route' do
      page_path('one/two').should eq '/other_pages/one/two'
    end

    it 'recognizes a route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one'
        },
        '/other_pages/one'
      )
    end

    it 'recognizes a nested route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one/two'
        },
        '/other_pages/one/two'
      )
    end

    it 'recognizes a route with dots' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one.two.three'
        },
        '/other_pages/one.two.three'
      )
    end
  end

  context 'home page route' do
    before(:each) do
      HighVoltage.home_page = 'home'
      Rails.application.reload_routes!
    end

    it 'recognizes the root route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'home'
        },
        '/'
      )
    end
  end

  context 'disabled routes' do
    before(:each) do
      HighVoltage.routes = false
      Rails.application.reload_routes!
    end

    it 'does not recognize routes' do
      { :get => '/pages/one/two' }.should_not be_routable
    end
  end
end
