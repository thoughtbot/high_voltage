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

Enjoy!

Copyright (c) 2009 Thoughtbot, released under the MIT license

