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

Run
```
heroku login
heroku container:login
heroku addons:create heroku-redis:hobby-dev --app test-car
```

After the Redis installation is finished
Go to the app's settings on [Heroku](https://heroku.com/) -> Reveal Config Vars -> Copy the Redis URL Value

In our .env file set (Used in config/initializers/sidekiq.rb)
```
REDIS_URL=Redis_Url_Value/0
```

Run
```
heroku container:push web --app test-car --recursive
heroku container:release web --app test-car
heroku run rake secret --app test-car
heroku config:set --app test-car SECRET_KEY_BASE=secret_key
heroku run rake db:migrate --app test-car
```

From the .env file copy the values of (Also used in config/environments/production.rb, # Mailer Settings(line 97))
```
MAIL_USERNAME=
MAIL_PASSWORD=
```

Run
```
heroku config:set MAIL_USERNAME=value MAIL_PASSWORD=value --app test-car
heroku run bundle exec sidekiq -C config/sidekiq.yml --app test-car
```

Heroku runs the dynos we need. However, the problem is that If we're running on free dynos, then Heroku will put the web dyno to sleep automatically after 30 minutes of inactivity.

To solve that, we'll need to use the Heroku Scheduler addon to run a command that will wake up the dyno shortly before our cron job is scheduled to run, the Heroku Scheduler runs on a one-off dyno so the execution of this command is not dependent on our web dyno.

Run
```
heroku addons:create scheduler:standard --app test-car
```

Once added, we'll open up the addon in the web browser.
```
heroku addons:open scheduler --app test-car
```

In the web browser, click 'Add Job' and then let the command 
```
curl https://test-car.herokuapp.com/
```
run everyday at 12:00 AM UTC.


* ...
