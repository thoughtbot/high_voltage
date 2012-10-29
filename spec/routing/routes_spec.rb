require 'spec_helper'

describe 'routes' do
  context 'using default configuration' do
    it 'should generate normal resource route with id' do
      page_path(:id => 'one').should eq '/pages/one'
    end

    it 'should generate normal resource route with string' do
      page_path('one').should eq '/pages/one'
    end

    it 'should generate nested route with string' do
      page_path('one/two').should eq '/pages/one/two'
    end

    it 'should recognize nested route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one/two'
        },
        '/pages/one/two'
      )
    end

    it 'should recognize normal route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one'
        },
        '/pages/one'
      )
    end

    it 'should recognize normal route with dots' do
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

  context 'using root routing configuration' do
    around do |example|
      cached_high_voltage_route_drawer = HighVoltage.route_drawer
      HighVoltage.route_drawer = HighVoltage::RouteDrawers::Root
      Rails.application.reload_routes!

      example.run

      HighVoltage.route_drawer = cached_high_voltage_route_drawer
      Rails.application.reload_routes!
    end

    it 'should generate normal resource route with id' do
      page_path(:id => 'one').should eq '/one'
    end

    it 'should generate normal resource route with string' do
      page_path('one').should eq '/one'
    end

    it 'should generate nested route with string' do
      page_path('one/two').should eq '/one/two'
    end
  end

  context 'using a custom content_path' do
    around do |example|
      cached_high_voltage_content_path = HighVoltage.content_path
      HighVoltage.content_path = 'other_pages/'
      Rails.application.reload_routes!

      example.run

      HighVoltage.content_path = cached_high_voltage_content_path
      Rails.application.reload_routes!
    end

    it 'should generate normal resource route with id' do
      page_path(:id => 'one').should eq '/other_pages/one'
    end

    it 'should generate normal resource route with string' do
      page_path('one').should eq '/other_pages/one'
    end

    it 'should generate nested route with string' do
      page_path('one/two').should eq '/other_pages/one/two'
    end

    it 'should recognize nested route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one/two'
        },
        '/other_pages/one/two'
      )
    end

    it 'should recognize normal route' do
      assert_recognizes(
        {
          :controller => 'high_voltage/pages',
          :action => 'show',
          :id => 'one'
        },
        '/other_pages/one'
      )
    end

    it 'should recognize normal route with dots' do
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

  context 'with default configuration disabled' do
    around do |example|
      cached_high_voltage_routes = HighVoltage.routes
      HighVoltage.routes = false
      Rails.application.reload_routes!

      example.run

      HighVoltage.routes = cached_high_voltage_routes
      Rails.application.reload_routes!
    end

    it 'should not recognize routes' do
      { :get => '/pages/one/two' }.should_not be_routable
    end
  end
end
