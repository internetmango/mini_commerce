[![pipeline status](https://gitlab.com/internetmango/mini_shop/badges/master/pipeline.svg)](https://gitlab.com/internetmango/mini_shop/-/commits/master)
[![coverage report](https://gitlab.com/internetmango/mini_shop/badges/master/coverage.svg)](https://gitlab.com/internetmango/mini_shop/-/commits/master)


# Mini Shop

Mini Shop is a basic e-commerce solution built with Ruby on Rails 6.0

## Demo

You can view the demo deployed to heroku at [https://minishopdemo.herokuapp.com](https://minishopdemo.herokuapp.com).

#### Admin Credentials

You can login to the admin dashboard using the *Email* admin@example.com and *Password* mangointernet

## Development Setup

Run the following commands to setup the Rails app in your local machine.

```sh

bundle install
yarn install

bundle exec rails db:migrate
bundle exec rails db:seed

bundle exec rails server
```

## Running Tests

Run RSpec by running the following command

```
bundle exec rspec
```

## Contributing

Coming Soon

## License
MIT Licensed
