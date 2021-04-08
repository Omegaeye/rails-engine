# Rails-Engine
  * Rails-Engine is an app that for developers to access the business database. The users are allow to search/find informations on merchants, items, and their invoices, as well as business analytic statistic

  https://github.com/Omegaeye/rails-engine

## Authors

- **Khoa Nguyen** - github - https://github.com/Omegaeye

## Table of Contents

  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Built With](#built-with)
  - [Authors](#authors)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

### GemFile/Dependency

  ```
  gem 'fast_jsonapi'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'pry'
  gem 'simplecov'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'orderly'
  gem 'factory_bot_rails'
  gem 'faker'
  ```


### Prerequisites

What things you need to install the software and how to install them

* rails
```sh
gem install rails --version 5.2.4.3
```

### Installing

    1. Clone Repo
    2. Install gem packages: `bundle install`
    3. Setup the database: `rails db:create`
    4. Migrate and Seed the database: `rails db:setup`


## App Highlights

  * Search for an items by prices

<img src="https://user-images.githubusercontent.com/46826902/114095050-38203900-987a-11eb-8c5e-281b5857c62f.png" width="50%" height="50%">

## Running the tests

In order to run all tests and see coverage run:

  ```
  bundle exec rspec
  ```

### Test Highlights

  This test access the url "/api/v1/merchants"

  ```
  it "renders a successful response" do
    get api_v1_merchants_url, headers: valid_headers, as: :json
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].class).to eq(Array)
    expect(body[:data].first.class).to eq(Hash)
  end
  ```

## Deployment
  * This app is screened through Travis CI before deploying to Heroku.
  * Need API Key from themoviedb.org
      * create an account https://www.themoviedb.org/
      * Apply for Api key https://www.themoviedb.org/settings/api
      * Input Api Key to application.yml, run:  
        ```
        atom config/application.yml
        ```
        ![Screen Shot 2021-03-30 at 11 08 56 AM](https://user-images.githubusercontent.com/46826902/113028529-9c3f5080-9148-11eb-935a-d39b8076bf17.png)
  * Hosted on: Heroku - https://morning-savannah-16693.herokuapp.com/

## Built With

  - Ruby/Rails
  - javascript/jquery

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments

  - Hat tip to anyone whose code was used
  - Inspiration
  - etc
