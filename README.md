# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

### How to Deploy This App to Heroku via Heroku CLI using Dockerfile.web, install Redis addon, config Mail ENV Variables and run Sidekiq
Assuming Heroku Postgres addon is already installed and our config/database.yml is configured

In the CLI
```
heroku login
heroku container:login
heroku addons:create heroku-redis:hobby-dev --app test-car
```

After the Redis installation is finished
Go to the app's settings on [Heroku](https://heroku.com/) -> Reveal Config Vars -> Copy the Redis URL Value

In our .env file set
```
REDIS_URL=Redis_Url_Value/0
```

In the CLI
```
heroku container:push web --app test-car --recursive
heroku container:release web --app test-car
heroku run rake secret --app test-car
heroku config:set --app test-car SECRET_KEY_BASE=secret_key
heroku run rake db:migrate --app test-car
```

From the .env file copy the values of
```
MAIL_USERNAME=
MAIL_PASSWORD=
```

In the CLI
```
heroku config:set MAIL_USERNAME=value MAIL_PASSWORD=value --app test-car
heroku run bundle exec sidekiq -C config/sidekiq.yml --app test-car
```

* ...
