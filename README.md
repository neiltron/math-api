# math-api

[![Gem Version](https://badge.fury.io/rb/math-api.png)](http://badge.fury.io/rb/math-api)
[![Code Climate](https://codeclimate.com/github/neiltron/math-api.png)](https://codeclimate.com/github/neiltron/math-api)

API wrapper for Mathematics.io

## Installation

Add this line to your application's Gemfile:

    gem 'math-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install math-api

## Usage

    @math = Math::API.new( accesskey: MATH_APIKEY, user_id: MATH_USERID, math_url: MATH_URL )
    @math.create_records({ item_name: 'athing', amount: 25 })

`math_url` is optional and will default to `mathematics.io`.

`create_records` will also accept a `timestamp` argument. If none is specified, it will default to `Time.now`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
