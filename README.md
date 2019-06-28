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


## Helper packs

### Aliases

```ruby
# config/initializers/console.rb

require 'rails_console_toolkit/aliases'
```

```
> x # alias exit
> r # alias reload!
```


### Utils

```ruby
# config/initializers/console.rb

require 'rails_console_toolkit/aliases'
```

```
> benchmark("foo") { sleep 3 }
foo (3000.6ms)
=> 3

> bm # alias benchmark
```


### [Solidus](https://solidus.io)

```ruby
# config/initializers/console.rb

require 'rails_console_toolkit/aliases'
```

```
> load_factories # will load solidus factories, useful to create dummy data in development
> product(...) # => will look for Spree::Product records by :id, :slug, :name
> variant(...) # => will look for Spree::Variant records by :id, :sku
> taxon(...)   # => will look for Spree::Taxon   records by :id, :permalink
> order(...)   # => will look for Spree::Order   records by :id, :number
> user(...)    # => will look for Spree::User    records by :id, :email
> country(...) # => will look for Spree::Country records by :id, :iso, :iso3, :iso_name, :name
```

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

### Model helpers

```ruby
# config/initializers/console.rb

RailsConsoleToolkit.model_helper 'Spree::Product', as: :product, by: %i[:name, :slug]
```


```
# bin/rails console

> product('black-tshirt') # => #<Spree::Product id: 123, name: "Black T-Shirt", slug: "black-tshirt", …>
> product.slug            # => "black-tshirt"
> product 456             # => #<Spree::Product id: 456, name: "Red T-Shirt", slug: "red-tshirt", …>
> product.slug            # => "red-tshirt"
```

### Removing unwanted helpers

```ruby
# config/initializers/console.rb

require 'rails_console_toolkit/aliases' # Will define an alias :x for "exit"

RailsConsoleToolkit.remove_helper :x
RailsConsoleToolkit.install!
```

```
# bin/rails console

> x # NameError (undefined local variable or method \`x' for main:Object)
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
