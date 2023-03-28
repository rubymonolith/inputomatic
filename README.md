# Inputomatic

What if instead of over-engineered date pickers for web apps people could enter dates like, `Next week`, `March 20, 2022`, `1 year from now`, etc?

How many times have you been annoyed that your expense reimbursement application can't do simple math like `200 / 2` because you only need to expense half the item?

Inputomatic handles these use cases so you can build more powerful web applications with simpler user interfaces.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add inputomatic

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install inputomatic

## Usage

In your ActiveRecord models, add the following to enable inputomatic:

```ruby
class Expense < ApplicationRecord
    belongs_to :report

    # Enable inputs like `100/2`, `13 + 78.9`, `80 - (90 / 2)`, etc.
    # which evaluates to the expected arithmetic number.
    attribute :amount, Inputomatic::Number.new

    # Enable inputs like `Next week`, `1 year ago`, `37 minutes from now`,
    # `Tuesday`, `Mar 3`, `10-10-2022`, `August 3, 2027`, `5:00p`, etc.
    # which evaluates to the expexted DateTime.
    attribute :expensed_at, Inputomatic::DateTime.new
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rocketshipio/inputomatic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rocketshipio/inputomatic/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Inputomatic project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rocketshipio/inputomatic/blob/main/CODE_OF_CONDUCT.md).
