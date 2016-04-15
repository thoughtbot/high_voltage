# High Voltage [![Build Status](https://travis-ci.org/thoughtbot/high_voltage.png)](http://travis-ci.org/thoughtbot/high_voltage)

Rails engine for static pages.

... but be careful. [Danger!](http://www.youtube.com/watch?v=HD5tnb2RBYg)

## Static pages?

Yeah, like "About us", "Directions", marketing pages, etc.

## Installation

    $ gem install high_voltage

Include in your Gemfile:

```ruby
gem 'high_voltage', '~> 3.0.0'
```

## Usage

Write your static pages and put them in the RAILS_ROOT/app/views/pages directory.

    $ mkdir app/views/pages
    $ touch app/views/pages/about.html.erb

After putting something interesting there, you can link to it from anywhere in your app with:

```ruby
<%= link_to 'About', page_path('about') %>
```

You can nest pages in a directory structure, if that makes sense from a URL perspective for you:

```ruby
<%= link_to 'Q4 Reports', page_path('about/corporate/policies/HR/en_US/biz/sales/Quarter-Four') %>
```

Bam.

You can also get a list of your static pages by calling `HighVoltage.page_ids`
This might be useful if you need to build a sitemap. For example, if you are
using the [sitemap_generator](https://github.com/kjvarga/sitemap_generator) gem,
you could add something like this to your sitemap config file:

```ruby
HighVoltage.page_ids.each do |page|
  add page, changefreq: 'monthly'
end
```

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

#### Specifying Rails engine for routes

If you are using multiple Rails engines within your application, you can
specify which engine to define the default HighVoltage routes on.

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.parent_engine = MyEngine
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

Built in caching support has been removed in HighVoltage. See [PR 221](https://github.com/thoughtbot/high_voltage/pull/221).

Page caching and action caching can be done via Rails. Visit the [Caching with
Rails: An overview](http://guides.rubyonrails.org/caching_with_rails.html) guide
for more details. You can utilize the methods described there by overriding the
HighVoltage controller as described [below](#override).

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

To set up a different layout for all High Voltage static pages, use an initializer:

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.layout = 'your_layout'
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

## Localization

[Rails I18n guides](http://guides.rubyonrails.org/i18n.html).

Add a before filter to the Application controller

```ruby
# app/controllers/application_controller.rb
before_action :set_locale

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
```

Disable the default High Voltage routes

```ruby
# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.routes = false
end
```

```ruby
# config/routes.rb
scope "/:locale", locale: /en|bn|hi/ do
  get "/pages/:id" => "high_voltage/pages#show", :as => :page, :format => false
end
```

Add a static page to the project

```
# app/views/pages/about.html.erb
<%= t "hello" %>
```

Make sure that there are corresponding locale files

```
/config/locale/bn.yml
/config/locale/en.yml
/config/locale/hi.yml
```

One last note is there is a [know
issue](https://github.com/thoughtbot/high_voltage/issues/59) with High Voltage.

You'll need to specify routes like this `<%= link_to "About Us", page_path(id:
"about") %>`

## Testing

You can test your static pages using [RSpec](https://github.com/rspec/rspec-rails)
and [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers):

```ruby
# spec/controllers/pages_controller_spec.rb
describe PagesController, '#show' do
  %w(earn_money screencast about contact).each do |page|
    context "on GET to /pages/#{page}" do
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

Please see [CONTRIBUTING.md].
Thank you, [contributors]!

[CONTRIBUTING.md]: /CONTRIBUTING.md
[contributors]: https://github.com/thoughtbot/high_voltage/graphs/contributors

## License

High Voltage is copyright © 2009-2016 thoughtbot. It is free software, and may
be redistributed under the terms specified in the [`LICENSE`] file.

[`LICENSE`]: /MIT-LICENSE

## About thoughtbot

![thoughtbot](https://thoughtbot.com/logo.png)

High Voltage is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
