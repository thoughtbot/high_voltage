require 'test_helper'

class ApplicationController < ActionController::Base
end

require "pages_controller"
require File.join(File.dirname(__FILE__), '..', 'config', 'routes')

class PagesControllerTest < ActionController::TestCase

  PagesController.view_paths << "/tmp"

  context "on GET to a page that exists" do
    setup do
      @filename = '/tmp/pages/exists.html.erb'

      FileUtils.mkdir(File.dirname(@filename))
      File.open(@filename, 'w') do |file|
        file << "hello <%= 'world' %>"
      end
      assert File.exists?(@filename)

      get :show, :id => 'exists'
    end

    should_respond_with :success
    should_render_template 'exists'

    teardown do
      begin
        FileUtils.rm(@filename)
        FileUtils.rmdir(File.dirname(@filename))
      rescue StandardError => e
        puts "Error while removing files: #{e}"
      end
    end
  end

  context "on GET to /pages/invalid" do
    setup { get :show, :id => "invalid" }
    should_respond_with :missing
  end  
  
  context "on GET to /pages" do
    setup { get :index }
    should_respond_with :missing
  end
end
