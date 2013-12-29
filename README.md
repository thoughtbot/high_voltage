# High Voltage [![Build Status](https://travis-ci.org/thoughtbot/high_voltage.png)](http://travis-ci.org/thoughtbot/high_voltage)

Rails engine for static pages.

... but be careful. [Danger!](http://www.youtube.com/watch?v=HD5tnb2RBYg)

## Static pages?

Yeah, like "About us", "Directions", marketing pages, etc.

## Installation

    $ gem install high_voltage

Include in your Gemfile:

```ruby
gem 'high_voltage', '~> 2.1.0'
```

For Rails versions prior to 3.0, use the 0.9.2 tag of high_voltage:

    https://github.com/thoughtbot/high_voltage/tree/v0.9.2

## Usage

Write your static pages and put them in the RAILS_ROOT/app/views/pages directory.

    $ mkdir app/views/pages
    $ touch app/views/pages/about.html.erb

After putting something interesting there, you can link to it from anywhere in your app with:

```ruby
link_to 'About', page_path('about')
```

You can nest pages in a directory structure, if that makes sense from a URL perspective for you:

```ruby
link_to 'Q4 Reports', page_path('about/corporate/policies/HR/en_US/biz/sales/Quarter-Four')
```

Bam.

## Configuration

#### Routing overview

By default, the static page routes will be like /pages/:id (where :id is the view filename).

If you want to route to a static page in another location (for example, a homepage), do this:

```ruby
get 'pages/home' => 'high_voltage/pages#show', id: 'home'
```

In that case, you'd need an `app/views/pages/home.html.erb` file.

Generally speaking, you need to route to the 'show' action with an `:id` param of the view filename.

High Voltage will generate a named route method of `page_path`. If you want to generate
your own named route (with the :as routing option), make sure not to use `:page`
as it will conflict with the High Voltage named route.

#### Specifying a root path

You can configure the root route to a High Voltage page like this:

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.home_page = 'home'
end
```

Which will render the page from `app/views/pages/home.html.erb` when the '/'
route of the site is accessed.

Note: High Voltage also creates a search engine friendly 301 redirect. Any attempt to
access the path '/home' will be redirected to '/'.

#### Top-level routes

You can remove the directory `pages` from the URL path and serve up routes from
the root of the domain path:

    http://www.example.com/about
    http://www.example.com/company

Would look for corresponding files:

    app/views/pages/about.html.erb
    app/views/pages/company.html.erb

This is accomplished by setting the `route_drawer` to `HighVoltage::RouteDrawers::Root`

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.route_drawer = HighVoltage::RouteDrawers::Root
end
```

#### Disabling routes

The default routes can be completely removed by setting the `routes` to `false`:

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.routes = false
end
```

#### Page titles and meta-data

We suggest using `content_for` and `yield` for setting custom page titles and
meta-data on High Voltage pages.

```ruby
# app/views/pages/about.html.erb
<%= content_for :page_title, 'About Us - Custom page title' %>
```

Then print the contents of `:title` into the layout:

```ruby
# app/views/layouts/application.html.erb
<title><%= yield(:page_title) %></title>
```
#### Content path

High Voltage uses a default path and folder of 'pages', i.e. 'url.com/pages/contact',
'app/views/pages'.

You can change this in an initializer:

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.content_path = 'site/'
end
```

#### Caching

High Voltage supports both [page](http://guides.rubyonrails.org/caching_with_rails.html#page-caching) and [action caching](http://guides.rubyonrails.org/caching_with_rails.html#action-caching).

To enable action-caching you can add the following to your initializer:

```ruby
# config/initializers/high_voltage.rb
HighVolgate.configure do |config|
  config.action_caching = true
  config.action_caching_layout = false # optionally do not cache layout. default is true.
end
```

To enable page-caching:

```ruby
# config/initializers/high_voltage.rb
HighVolgate.configure do |config|
  config.page_caching = true
end
```

High Voltage will use your default cache store to store action caches.

Using caching with Ruby on Rails 4 or higher requires gems:

```ruby
# Gemfile
gem 'actionpack-action_caching'
gem 'actionpack-page_caching'
```

## Override

Most common reasons to override?

  * You need authentication around the pages to make sure a user is signed in.
  * You need to render different layouts for different pages.
  * You need to render a partial from the `app/views/pages` directory.

Create a `PagesController` of your own:

    $ rails generate controller pages

Disable the default routes:

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.routes = false
end
```

Define a route for the new `PagesController`:

```ruby
# config/routes.rb
get "/pages/*id" => 'pages#show', as: :page, format: false

# if routing the root path, update for your controller
root to: 'pages#show', id: 'home'
```

Then modify new `PagesController` to include the High Voltage static page concern:

```ruby
# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_filter :authenticate
  layout :layout_for_page

  private

  def layout_for_page
    case params[:id]
    when 'home'
      'home'
    else
      'application'
    end
  end
end
```

## Custom finding

You can further control the algorithm used to find pages by overriding
the `page_finder_factory` method:

```ruby
# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  private

  def page_finder_factory
    Rot13PageFinder
  end
end
```

The easiest thing is to subclass `HighVoltage::PageFinder`, which
provides you with `page_id`:

```ruby
class Rot13PageFinder < HighVoltage::PageFinder
  def find
    paths = super.split('/')
    directory = paths[0..-2]
    filename = paths[-1].tr('a-z','n-za-m')

    File.join(*directory, filename)
  end
end
```

Use this to create a custom file mapping, clean filenames for your file
system, A/B test, and so on.

## Testing

You can test your static pages using [RSpec](https://github.com/rspec/rspec-rails)
and [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers):

```ruby
# spec/controllers/pages_controller_spec.rb
describe PagesController, '#show' do
  %w(earn_money screencast about contact).each do |page|
    context 'on GET to /pages/#{page}' do
      before do
        get :show, id: page
      end

      it { should respond_with(:success) }
      it { should render_template(page) }
    end
  end
end
```

If you're not using a custom PagesController be sure to test
`HighVoltage::PagesController` instead.

Enjoy!

## Contributing

Please see [CONTRIBUTING.md](https://github.com/thoughtbot/high_voltage/blob/master/CONTRIBUTING.md)
for details.

## Credits

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

High Voltage is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/high_voltage/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

High Voltage is Copyright © 2009-2013 thoughtbot. It is free software, and may
be redistributed under the terms specified in the MIT-LICENSE file.
