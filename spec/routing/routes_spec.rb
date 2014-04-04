require 'spec_helper'

describe 'routes' do
  context 'default configuration' do
    it 'generates a route' do
      expect(page_path('one')).to eq '/pages/one'
    end

    it 'generates a nested route' do
      expect(page_path('one/two')).to eq '/pages/one/two'
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
      expect(page_path('one')).to eq '/one'
    end

    it 'generates  a nested route' do
      expect(page_path('one/two')).to eq '/one/two'
    end
  end

  context 'custom content path' do
    before(:each) do
      HighVoltage.content_path = 'other_pages/'
      Rails.application.reload_routes!
    end

    it 'generates a route' do
      expect(page_path('one')).to eq '/other_pages/one'
    end

    it 'generates a nested route' do
      expect(page_path('one/two')).to eq '/other_pages/one/two'
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
    it 'recognizes the root route' do
      HighVoltage.home_page = 'home'
      Rails.application.reload_routes!

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

  context 'no home page route' do
    it 'does generate a home page route' do
      expect(get: '/').not_to be_routable
    end
  end

  context 'disabled routes' do
    it 'does not recognize routes' do
      HighVoltage.routes = false
      Rails.application.reload_routes!

      expect(get: '/pages/one/two').not_to be_routable
    end
  end
end
