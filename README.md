## Contribute

- fork this repository
- contribute
- send pull request

## Install

- git clone git@github.com:<your_user_name>/kuende.git
- bundle install
- cp config/database.yml.sample config/database.yml
- keep pg db adapter (we might need some Postgresql specific things)
- rake db:create
- rake db:migrate
- bin/rails server

## Rails 4.0 fixes

- `rails` binary is now in `bin/rails`, so instead of `rails console` you have to run `bin/rails console` or create an alias: `alias rails="bin/rails"` 