# Changelog

## [3.1.2] - 2019-05-20

### Fixed

+ The previous release unintentionally included a `setup` script meant for
  development only in the packaged gem. This has been removed.

## [3.1.1] - 2019-05-13

### Fixed

+ Fix UTF-8 encoding error being raised on page requests - [#273]

## [3.1.0] - 2018-05-04

+ Fix bugs around finding pages via page_ids's that contain non-ASCII characters
+ Trailing slash is no longer required for finding pages
+ Some other improvements around page lookups
+ Don't require format in extension for looking up page id's HAML and Slim do
  not require them.
+ Test against Rails 5, 5.1, 5.2
+ Test against Ruby 2.4, 2.5

## [3.0.0] - 2016-04-15

+ HighVoltage now supports Rails 5.0.0.beta3 and up.
+ Properly handle extensions in root route constraint requests.
+ Removes caching in preparation for Rails 5.

## [2.4.0] - 2015-07-17

+ Retrieve a list of available static pages via `HighVoltage.page_ids`.
+ Properly handle page ids which are blank when being sanitized.
+ Only provide deprecation warnings around caching when caching is enabled.

## [2.3.0] - 2015-04-17

+ Ruby 2.2 and Rails 4.2 testing
+ Raise InvalidPageIdError when visiting a page with invalid characters
+ Code of Conduct added to Contributing guide

## [2.2.1] - 2014-07-23

+ Resolve issue with require statements for Rails 3.x projects

## [2.2.0] - 2014-06-24

+ Deprecate caching because page and action caching was removed in Rails 4
+ Refactor test suite to use rspec `expect` syntax consistently.
+ Added Rails 4.1 to test suite.
+ Remove Ruby 1.9.2 from test suite.
+ Remove Capybara from test suite.
+ Support dependency injection for Rails engine to define routes on

## [2.1.0] - 2013-12-30

+ Extract configuration options into a module
+ Add ability to configure whether layout is cached with action_caching
+ Add ability to configure a `home_page` for root routing to High Voltage
+ Update README with new block style config

## [2.0.0] - 2013-10-05

+ Extract PagesController into a module
+ Update README with module usage instructions

## [1.2.4] - 2013-07-19

+ Add page and action caching
+ Remove redundant link style `page_path(id: 'about')` from README
+ Clean up Appraisals for Travis-CI
+ Remove Ruby 1.8.7 from test suite

## [1.2.3] - 2013-07-04

+ Updates for Rails 4 compatibility.
+ Fix for Rails 4 circular dependency error.
+ Add ability to load High Voltage outside of rails. Require `attribute_accessors`

## [1.2.2] - 2013-07-04

+ Bug fix for RootRoute constraint. Support haml, slim, etc.
+ README updated for root routes.

## [1.2.1] - 2013-10-30

+ Ability to disable HighVoltage routes.
+ New RootRoute constraint.
+ Updated README, with new TravisCI url.

[3.1.2]: https://github.com/thoughtbot/high_voltage/compare/v3.1.1...v3.1.2
[3.1.1]: https://github.com/thoughtbot/high_voltage/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/thoughtbot/high_voltage/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/thoughtbot/high_voltage/compare/v2.4.0...v3.0.0
[2.4.0]: https://github.com/thoughtbot/high_voltage/compare/v2.3.0...v2.4.0
[2.3.0]: https://github.com/thoughtbot/high_voltage/compare/v2.2.1...v2.3.0
[2.2.1]: https://github.com/thoughtbot/high_voltage/compare/v2.2.0...v2.2.1
[2.2.0]: https://github.com/thoughtbot/high_voltage/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/thoughtbot/high_voltage/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/thoughtbot/high_voltage/compare/v1.2.4...v2.0.0
[1.2.4]: https://github.com/thoughtbot/high_voltage/compare/v1.2.3...v1.2.4
[1.2.3]: https://github.com/thoughtbot/high_voltage/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/thoughtbot/high_voltage/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/thoughtbot/high_voltage/compare/v1.2.0...v1.2.1

[#273]: https://github.com/thoughtbot/high_voltage/pull/273
