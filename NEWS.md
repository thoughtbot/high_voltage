New for 3.0.0
+ HighVoltage now supports Rails 5.0.0.beta3 and up.
+ Properly handle extensions in root route constraint requests.
+ Removes caching in preparation for Rails 5.

New for 2.4.0
+ Retrieve a list of available static pages via `HighVoltage.page_ids`.
+ Properly handle page ids which are blank when being sanitized.
+ Only provide deprecation warnings around caching when caching is enabled.

New for 2.3.0:
+ Ruby 2.2 and Rails 4.2 testing
+ Raise InvalidPageIdError when visiting a page with invalid characters
+ Code of Conduct added to Contributing guide

New for 2.2.1:
+ Resolve issue with require statements for Rails 3.x projects

New for 2.2.0:
+ Deprecate caching because page and action caching was removed in Rails 4
+ Refactor test suite to use rspec `expect` syntax consistently.
+ Added Rails 4.1 to test suite.
+ Remove Ruby 1.9.2 from test suite.
+ Remove Capybara from test suite.
+ Support dependency injection for Rails engine to define routes on

New for 2.1.0:
+ Extract configuration options into a module
+ Add ability to configure whether layout is cached with action_caching
+ Add ability to configure a `home_page` for root routing to High Voltage
+ Update README with new block style config

New for 2.0.0:
+ Extract PagesController into a module
+ Update README with module usage instructions

New for 1.2.4:
+ Add page and action caching
+ Remove redundant link style `page_path(id: 'about')` from README
+ Clean up Appraisals for Travis-CI
+ Remove Ruby 1.8.7 from test suite

New for 1.2.3:
+ Updates for Rails 4 compatibility.
+ Fix for Rails 4 circular dependency error.
+ Add ability to load High Voltage outside of rails. Require `attribute_accessors`

New for 1.2.2:
+ Bug fix for RootRoute constraint. Support haml, slim, etc.
+ README updated for root routes.

New for 1.2.1:
+ Ability to disable HighVoltage routes.
+ New RootRoute constraint.
+ Updated README, with new TravisCI url.
