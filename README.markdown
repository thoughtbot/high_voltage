High Voltage
============

Rails engine for static pages.

... but be careful. [Danger!](http://www.youtube.com/watch?v=HD5tnb2RBYg)

Static pages?
-------------

Yeah, like "About us", "Directions", marketing pages, etc.

Installation
------------

    script/plugin install git://github.com/thoughtbot/high_voltage.git

Usage
-----

Write your static pages and put them in the RAILS_ROOT/app/views/pages directory.

    mkdir app/views/pages
    touch app/views/pages/about.html.erb

After putting something interesting there, you can link to it from anywhere in your app with:

    link_to "About", page_path("about")

Bam.

Override
--------

Most common reasons to override? Authentication, layouts.

Create a PagesController of your own:

    script/generate controller pages

Then modify it to subclass from High Voltage, adding whatever you need:

    class PagesController < HighVoltage::PagesController
      before_filter :authenticate
      layout "danger"
    end

Don't forget to add the new route:

    map.resources :pages,
      :controller => 'pages',
      :only       => [:show]

Testing
-------

Just a suggestion, but you can test your pages using Shoulda pretty easily:

    class PagesControllerTest < ActionController::TestCase
      tests PagesController

      %w(earn_money screencast about contact).each do |page|
        context "on GET to /pages/#{page}" do
          setup { get :show, :id => page }

          should_respond_with :success
          should_render_template page
        end
      end
    end

If you're not using a custom PagesController be sure to test <code>HighVoltage::PagesController</code> instead.

Enjoy!

Copyright (c) 2009 Thoughtbot, released under the MIT license

