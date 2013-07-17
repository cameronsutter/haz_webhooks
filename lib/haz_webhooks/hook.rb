module HazWebhooks
  module Hook
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      #events is an array of strings that are the key for the event
      def haz_webhooks(events)
        class_eval do
          @webhook_events = events
          has_many :webhooks, :as => :hook, :class_name => 'HazWebhooks::Webhook'
          
          def after_initialize
            #initialize with events
            @webhook_events.each do |e|
              self.webhooks.create(:key => e, :active => true)
            end
          end
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, HazWebhooks::Hook