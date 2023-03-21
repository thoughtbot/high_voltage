# encoding: utf-8

require "spec_helper"

describe HighVoltage::PagesController do
  render_views

  context "using default configuration" do
    describe "on GET to /pages/exists" do
      before { get :show, params: { id: "exists" } }

      it "responds with success and render template" do
        expect(response).to be_successful
        expect(response).to render_template("exists")
      end

      it "uses the default layout used by ApplicationController" do
        expect(response).to render_template("layouts/application")
      end

      it "uses the default render streaming false" do
        expect(response.headers["Transfer-Encoding"]).to be_nil
      end
    end

    describe "on GET to /pages/dir/nested" do
      before { get :show, params: { id: "dir/nested" } }

      it "responds with success and render template" do
        expect(response).to be_successful
        expect(response).to render_template("pages/dir/nested")
      end
    end

    it "raises a routing error for an invalid page" do
      expect { get :show, params: { id: "invalid" } }.
        to raise_error(ActionController::RoutingError)
    end

    it "raises a routing error for a page in another directory" do
      expect { get :show, params: { id: "../other/wrong" } }.
        to raise_error(ActionController::RoutingError)
    end

    it "raises a missing template error for valid page with invalid partial" do
      expect { nonexistent_partial_request }.
        to raise_error(ActionView::MissingTemplate)
    end

    def nonexistent_partial_request
      get :show, params: {
        id: "exists_but_references_nonexistent_partial",
      }
    end
  end

  context "using streaming response" do
    describe "on GET to /pages/exists" do
      before { get :show, params: { id: "exists" } }

      it "responds with chunked transfer encoding" do
        expect(response.headers["Transfer-Encoding"]).to_not be_nil
        expect(response.headers["Transfer-Encoding"]).to eq "chunked"
      end
    end
  end

  context "using custom layout" do
    before(:each) do
      HighVoltage.layout = "alternate"
    end

    describe "on GET to /pages/exists" do
      before { get :show, params: { id: "exists" } }

      it "uses the custom configured layout" do
        expect(response).not_to render_template("layouts/application")
        expect(response).to render_template("layouts/alternate")
      end
    end
  end

  context "using custom content path" do
    before(:each) do
      HighVoltage.content_path = "other_pages/"
      Rails.application.reload_routes!
    end

    describe "on GET to /other_pages/also_exists" do
      before { get :show, params: { id: "also_exists" } }

      it "responds with success and render template" do
        expect(response).to be_successful
        expect(response).to render_template("other_pages/also_exists")
      end
    end

    describe "on GET to /other_pages/also_dir/nested" do
      before { get :show, params: { id: "also_dir/also_nested" } }

      it "responds with success and render template" do
        expect(response).to be_successful
        expect(response).to render_template("other_pages/also_dir/also_nested")
      end
    end

    it "raises a routing error for an invalid page" do
      expect { get :show, params: { id: "also_invalid" } }.
        to raise_error(ActionController::RoutingError)

      expect { get :show, params: { id: "√®ø" } }.
        to raise_error(ActionController::RoutingError)
    end

    context "page in another directory" do
      it "raises a routing error" do
        expect { get :show, params: { id: "../other_wrong" } }.
          to raise_error(ActionController::RoutingError)
      end

      it "raises a routing error when using a Unicode exploit" do
        expect { get :show, params: { id: "/\\../other/wrong" } }.
          to raise_error(ActionController::RoutingError)
      end
    end

    it "raises a missing template error for valid page with invalid partial" do
      id = "also_exists_but_references_nonexistent_partial"

      expect { get :show, params: { id: id } }.
        to raise_error(ActionView::MissingTemplate)
    end
  end
end
