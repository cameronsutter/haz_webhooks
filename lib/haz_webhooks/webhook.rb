require 'httparty'

module HazWebhooks
  class Webhook < ::ActiveRecord::Base
    include HTTParty
    belongs_to :actor, :polymorphic => true
    attr_accessible :url, :key, :active

    def set(theURL)
      self.url = theURL
      save
    end

    def fire(data)
      Thread.new do
        post(url, :query => data)
      end
    end

    scope :active, where(:active => true)

    scope :event, lambda {|name| active.where(:key => name)}
  end
end