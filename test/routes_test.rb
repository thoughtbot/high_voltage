require 'test_helper'

class RoutesTest < ActionController::TestCase

  include Rails.application.routes.url_helpers

  test "generates normal resource route with id" do
    assert_equal "/pages/one", page_path(:id => "one")
  end

  test "generates normal resource route with string" do
    assert_equal "/pages/one", page_path("one")
  end

  test "generates nested route with string" do
    assert_equal "/pages/one/two", page_path("one/two")
  end

  test "recognizes nested route" do
    assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one/two" }, "/pages/one/two")
  end

  test "recognizes normal route" do
    assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one" }, "/pages/one")
  end

  test "recognizes normal route with dots" do
    assert_recognizes({ :controller => "high_voltage/pages", :action => "show", :id => "one.two.three" }, "/pages/one.two.three")
  end

end
