[![Build Status](https://travis-ci.org/zanloy/picard.svg)](https://travis-ci.org/zanloy/picard)
[![Coverage Status](https://coveralls.io/repos/zanloy/picard/badge.svg?branch=master&service=github)](https://coveralls.io/github/zanloy/picard?branch=master)

Picard is a website designed to track engineering changes made by a team against
an application. It was designed to facilitate management tracking changes and
for accountability in case something breaks the application.

# Demo

You can demo Picard at [http://picard.zanloy.com/](http://picard.zanloy.com/).
You can use your gmail login to create an account or use the username
'test@test.com' and the password 'test123test123' to test the application.

**The database for this demo site gets reset every morning.**

# Installation

If you want to install the application on your own computer, you will need to be
using either Linux or Mac. Sorry, there are some requirements that do not work
on Windows.

## Requirements

You will need to have Ruby 2.3.1 installed. You will need to have PostgreSQL
installed and setup for your user to have admin (or at a minimum 'create
database') access (the application needs to build the database). You will need
to have ImageMagick installed as well for image processing of file attachments.
You will also need ElasticSearch installed and running to seed the database.
The application uses ES for full text searching and will not run without a
proper connection setup on port 9200.

## Steps

* Clone the repo

```
git clone https://github.com/zanloy/picard.git
```

* Create your environment file

In the picard directory, you will need to create a file called '.env' and put
some important information in there. The most important is your google auth
apikey and secret. Picard uses Google Oauth2 for authentication and without
this, you will not be able to login to the site. This site is designed to be
private so you can not access any information without logging in with an enabled
account.

Here is the format:

```
GOOGLE_CLIENT_ID="SUPERSECRETCLIENTID"
GOOGLE_SECRET="SUPERSECRETSECRET"

# This is only needed in Production. Use rake secret to generate a secret key.
SECRET_KEY_BASE='BLAH'
```

* Use bundler to install packages

Run the following command in the picard directory.

```
bundle install --path .bundle
```

* Generate the database

This will create the database and table schemas.

```
bundle exec rake db:create db:migrate
```

* Seed the database

```
bundle exec rake db:seed
```

* Start the web server

This will spawn 3 processes. One is the main web server, another is a
background worker for delayed jobs, and the third is a cron task for handling
daily tasks.

```
bundle exec foreman start
```

* Visit the site in your web browser

Finally if all has gone well, you can visit the site in your web browser by
going to [http://localhost:5000/](http://localhost:5000/). In development, you
can use a test user to login. Username: admin@test.com Password: test or
Username: test@test.com Password: test

## Deployment

I use [capistrano](http://capistranorb.com/) for deploying the website to my
web server. I won't go into a lot of detail here since that is beyond the scope
of this readme. You will need to edit config/deploy/production.rb to setup your
web server information.

## Issues

If you have any feature requests or notice any bugs, please add an issue on
[GitHub](https://github.com/zanloy/picard/issues).
