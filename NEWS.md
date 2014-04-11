New for 2.2.0:
+ Deprecate caching because page and action caching was removed in Rails 4

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
