[![Build Status](https://travis-ci.org/cookpad/janiConverter.svg?branch=master)](https://travis-ci.org/cookpad/janiConverter) [![Code Climate](https://codeclimate.com/github/shin1ohno/janiConverter/badges/gpa.svg)](https://codeclimate.com/github/shin1ohno/janiConverter) [![Test Coverage](https://codeclimate.com/github/shin1ohno/janiConverter/badges/coverage.svg)](https://codeclimate.com/github/shin1ohno/janiConverter)

setup

```
git clone git@github.com:cookpad/janiConverter.git
cd janiConverter
docker build -t cookpad/jani-converter:0.1 .
```

run rails

```
docker run -it -e DATABASE_HOST=xxx.xxx.xxx.xxx -e REDIS_URL=redis://xxx.xxx.xxx.xxx:xxxx -e AWS_UPLOAD_DIRECTORY=xxxx/xxxx -e AWS_PUBLISH_DIRECTORY=xxxx/xxxx -e DATABASE_USERNAME=xxxx -e DATABASE_PASSWORD=xxxx -e DATABASE_NAME=jani-converter -e SECRET_KEY_BASE=xxxxxxxxxx -e AWS_ACCESS_KEY_ID=xxxxx -e AWS_SECRET_ACCESS_KEY=xxxxx -e RAILS_ENV=production -p 8080:8080 cookpad/jani-converter:0.1 /sbin/my_init
```

run sidekiq workers

```
docker run -it -e DATABASE_HOST=xxx.xxx.xxx.xxx -e REDIS_URL=redis://xxx.xxx.xxx.xxx:xxxx -e AWS_UPLOAD_DIRECTORY=xxxx/xxxx -e AWS_PUBLISH_DIRECTORY=xxxx/xxxx -e DATABASE_USERNAME=xxxx -e DATABASE_PASSWORD=xxxx -e DATABASE_NAME=jani-converter -e SECRET_KEY_BASE=xxxxxxxxxx -e AWS_ACCESS_KEY_ID=xxxxx -e AWS_SECRET_ACCESS_KEY=xxxxx -e RAILS_ENV=production cookpad/jani-converter:0.1 bundle exec sidekiq
```
