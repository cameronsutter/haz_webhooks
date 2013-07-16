module HazWebhooks
  module Hook
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      #events is an array of strings that are the key for the event
      def haz_webhooks(events)
        class_eval do
          has_many :webhooks, :class_name => 'HazWebhooks::Webhook'
        end

        #initialize with events
        events.each do |e|
          self.webhooks.create(:key => e)
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, HazWebhooks::Hook