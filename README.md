# RailsConsoleToolkit

*Configurable Rails Console Helpers*

Find records faster, add custom helpers, improve your console life by 100%.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_console_toolkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_console_toolkit

## Usage

```ruby
# config/initializers/console.rb

# helper definitions go here...

RailsConsoleToolkit.install!
```


### Generic helpers

```ruby
# config/initializers/console.rb

RailsConsoleToolkit.helper :foo do
  :bar
end
```

```
# bin/rails console

> foo # => :bar
```

### Aliases

```ruby
# config/initializers/console.rb

RailsConsoleToolkit.alias :r, :reload!
```

```
# bin/rails console

> r # The same as typing "reload!"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elia/rails_console_toolkit.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## About

[![Nebulab][nebulab-logo]][nebulab]

This project is funded and maintained by the [Nebulab][nebulab] team.

We firmly believe in the power of open-source. [Contact us][contact-us] if you
like our work and you need help with your project design or development.

[nebulab]: http://nebulab.it/
[nebulab-logo]: http://nebulab.it/assets/images/public/logo.svg
