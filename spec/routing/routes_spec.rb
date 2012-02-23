require 'spec_helper'
describe 'routes' do
  context "using default configuration" do

    it "should generate normal resource route with id" do
      page_path(:id => "one").should == "/pages/one"
    end

    it "should generate normal resource route with string" do
      page_path("one").should == "/pages/one"
    end

    it "should generate nested route with string" do
      page_path("one/two").should == "/pages/one/two"
    end

    it "should recognize nested route" do
      assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one/two" }, "/pages/one/two")
    end

    it "should recognize normal route" do
      assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one" }, "/pages/one")
    end

    it "should recognize normal route with dots" do
      assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one.two.three" }, "/pages/one.two.three")
    end
  end

  context "using a custom content_path" do

    before(:all) do
      @original_content_path = HighVoltage::content_path
      HighVoltage::content_path = "other_pages/"
      Rails.application.reload_routes!
    end

    after(:all) do
      HighVoltage::content_path = @original_content_path
      Rails.application.reload_routes!
    end

    it "should generate normal resource route with id" do
      page_path(:id => "one").should == "/other_pages/one"
    end

    it "should generate normal resource route with string" do
      page_path("one").should == "/other_pages/one"
    end

    it "should generate nested route with string" do
      page_path("one/two").should == "/other_pages/one/two"
    end

    it "should recognize nested route" do
      assert_recognizes({:controller => "high_voltage/pages", :action => "show", :id => "one/two"}, "/other_pages/one/two")
    end

    it "should recognize normal route" do
      assert_recognizes({:controller => "high_voltage/pages", :action => "show", :id => "one"}, "/other_pages/one")
    end

    it "should recognize normal route with dots" do
      assert_recognizes({:controller => "high_voltage/pages", :action => "show", :id => "one.two.three"}, "/other_pages/one.two.three")
    end
  end

end
