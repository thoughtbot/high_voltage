# Contributing Guide

## Code of Conduct

We welcome pull requests from everyone. By participating in this project, you
agree to abide by the thoughtbot [code of conduct].

Note that this project is in maintenance-mode. We’re not actively adding new features. Bug
fixes and other contributions to keep it compatible with the latest Ruby and Rails versions
are welcomed.

We expect everyone to follow the code of conduct anywhere in thoughtbot's
project codebases, issue trackers, chat-rooms, and mailing lists.

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

### Running the application locally

```sh
bundle
```

Run the tests:

```sh
bundle exec rake
```

## Opening a PR

We love pull requests from everyone. By participating in this project, you
agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

1. Fork the repo.
2. Run the tests. We only take pull requests with passing tests, and it's great
   to know that you have a clean slate: `bundle && rake`
3. Add a test for your change. Only refactoring and documentation changes
   require no new tests. If you are adding functionality or fixing a bug, we need
   a test!
4. Make the test pass.
5. Push to your fork and submit a pull request.

At this point you're waiting on us. We like to at least comment on, if not
accept, pull requests within three business days (and, typically, one business
day). We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted,
taken straight from the Ruby on Rails guide:

- Use Rails idioms and helpers
- Include tests that fail without your code, and pass with it
- Update the documentation, the surrounding one, examples elsewhere, guides,
  whatever is affected by your contribution

### Syntax

- Two spaces, no tabs.
- No trailing whitespace. Blank lines should not have any space.
- Prefer &&/|| over and/or.
- MyClass.my_method(my_arg) not my_method( my_arg ) or my_method my_arg.
- a = b and not a=b.
- Follow the conventions you see used in the source already.

And in case we didn't emphasize it enough: we love tests!
