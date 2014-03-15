require 'spec_helper'

describe SubclassedPagesController do
  render_views

  describe 'on GET to /subclassed_pages/also_exists' do
    before { get :show, :id => 'also_exists' }

    it 'responds with success and render template' do
      expect(response).to be_succes
      expect(response).to render_template('also_exists')
    end

    it 'uses the custom configured layout' do
      expect(response).not_to render_template('layouts/application')
      expect(response).to render_template('layouts/alternate')
    end
  end

  it 'raises a routing error for an invalid page' do
    expect { get :show, id: 'invalid' }
      .to raise_error(ActionController::RoutingError)
  end

  it 'raises a routing error for a page in another directory' do
    expect { get :show, id: '../other/wrong' }
      .to raise_error(ActionController::RoutingError)
  end

  it 'raises a missing template error for valid page with invalid partial' do
    expect { get :show, id: 'also_exists_but_references_nonexistent_partial' }
      .to raise_error(ActionView::MissingTemplate)
  end
end
