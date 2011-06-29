High Voltage
============

Rails engine for static pages.

... but be careful. [Danger!](http://www.youtube.com/watch?v=HD5tnb2RBYg)

Static pages?
-------------

Yeah, like "About us", "Directions", marketing pages, etc.

Installation
------------

    $ gem install high_voltage

Include in your Gemfile:

    gem "high_voltage"

For Rails versions prior to 3.0, use the rails2 branch of high_voltage:
https://github.com/thoughtbot/high_voltage/tree/rails2    

Usage
-----

Write your static pages and put them in the RAILS_ROOT/app/views/pages directory.

    $ mkdir app/views/pages
    $ touch app/views/pages/about.html.erb

After putting something interesting there, you can link to it from anywhere in your app with:

    link_to "About", page_path("about")

This will also work, if you like the more explicit style:

    link_to "About", page_path(:id => "about")

You can nest pages in a directory structure, if that makes sense from a URL perspective for you:

    link_to "Q4 Reports", page_path("about/corporate/policies/HR/en_US/biz/sales/Quarter-Four")

Bam.

Routes
------

By default, the static page routes will be like /pages/:id (where :id is the view filename).

If you want to route to a static page in another location (for example, a homepage), do this:

    match 'pages/home' => 'high_voltage/pages#show', :id => 'home'

In that case, you'd need an app/views/pages/home.html.erb file.

Generally speaking, you need to route to the 'show' action with an :id param of the view filename.

You can route the root url to a high voltage page like this:

    root :to => 'high_voltage/pages#show', :id => 'home'

Which will render a homepage from app/views/pages/home.html.erb

Override
--------

Most common reasons to override?

  * You need authentication around the pages to make sure a user is signed in.
  * You need to render different layouts for different pages.

Create a PagesController of your own:

    $ rails generate controller pages

Override the default route:

    # in config/routes.rb
    resources :pages

Then modify it to subclass from High Voltage, adding whatever you need:

    class PagesController < HighVoltage::PagesController
      before_filter :authenticate
      layout :layout_for_page

      protected
        def layout_for_page
          case params[:id]
          when 'home'
            'home'
          else
            'application'
          end
        end
    end

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

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

High Voltage is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/high_voltage/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

High Voltage is Copyright © 2009-2011 thoughtbot. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
