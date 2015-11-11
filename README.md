[![Build Status](https://travis-ci.org/westernmilling/simple_loads.svg)](https://travis-ci.org/westernmilling/simple_loads)
[![Code Climate](https://codeclimate.com/github/westernmilling/simple_loads/badges/gpa.svg)](https://codeclimate.com/github/westernmilling/simple_loads)
[![Test Coverage](https://codeclimate.com/github/westernmilling/simple_loads/badges/coverage.svg)](https://codeclimate.com/github/westernmilling/simple_loads/coverage)
[![Dependency Status](https://gemnasium.com/westernmilling/simple_loads.svg)](https://gemnasium.com/westernmilling/simple_loads)

# simple_loads
This is a very crude "logistics" app to serve as a base for technical
exercises during the Western Milling Software Engineer recruitment process.

Candidates will be invited to complete at least one of the following
feature requests:

- A user should be able to ship a load in a discrete action that collects the
  weights and ship date of the load. This action should change the loads
  status to shipped. A load can only be shipped after is has been dispatched.
- A user should be able to create more than one load at a time for a single
  order number. Each load should be created the same, but with an incrementing
  load number.

And the following bug report:

- A user should be able to filter loads by driver, however the driver dropdown
  is not being populated with a list of the drivers who have loads.

And for bonus points:

- Improvements or refactoring of the existing code base.

It is expected that all changes will have accompanying test coverage and
pass rubocop, scss-lint, and jshint.

## Checking the app

From the project root directory run the appropriate tools as described below.

### Ruby Code Analysis

`rubocop --rails`

### Sass

`scss-lint`

### Javascript

jshint needs `npm` to install so make sure you have `node` installed first.

Install jshint with `npm install -g jshint`

Now you can run jshint with:

`jshint`

## Running the app

`foreman start`
