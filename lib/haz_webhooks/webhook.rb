require 'httparty'

module HazWebhooks
  class Webhook < ::ActiveRecord::Base
    include HTTParty
    belongs_to :hook, :polymorphic => true
    attr_accessible :url, :key, :active, :hook_id

    def set(theURL)
      self.url = theURL
      save
    end

    def fire(data=nil)
      Thread.new do
        post(url, :query => data)
      end
    end

    scope :active, where(:active => true)

    scope :event, lambda {|name| active.where(:key => name)}
  end
end