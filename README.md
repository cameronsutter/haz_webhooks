# HazWebhooks

Easily fire webhooks for any ActiveRecord model

## Installation

Add this line to your application's Gemfile:

    gem 'haz_webhooks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haz_webhooks

## Usage

add `haz_webhooks` to any ActiveRecord model with an array of events (arbitrary strings)

    class User < ActiveRecord::Base
      haz_webhooks ['post','update','score']
    end

set the url

    User.find(1).webhooks.event('post').set('www.example.com/receive_webhook')

fire the webhook

    data = {
      :id => post.id,
      :name => post.name,
      :poster => user.name
    }

    User.find(1).webhooks.event('post').fire(data)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
