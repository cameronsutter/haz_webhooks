module HazWebhooks
  module Hook
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      #events is an array of strings that are the key for the event
      def haz_webhooks(events)
        class_eval do
          has_many :webhooks, :as => :hook, :class_name => 'HazWebhooks::Webhook', :dependent => :delete_all
          @@events = events
          def webhook_events
            @@events
          end

          after_create :init_webhooks
          before_destroy :destroy_webhooks

          def init_webhooks
            @@events.each do |e|
              self.webhooks.create(:key => e, :active => true)
            end
          end

          def destroy_webhooks
            self.webhooks.clear
          end
        end
      end
    end

    def set_webhook(key, url)
      hook = self.webhooks.event(key).first
      if hook.nil?
        self.webhooks.create(:key => key, :active => true, :url => url)
      else
        hook.set(url)
      end
    end

    def fire_webhook(key, data)
      hook = self.webhooks.event(key).first
      hook.fire(data) if !hook.nil?
    end

    def webhook_url(key)
      self.webhooks.event(key).first.try(:url)
    end

  end
end

ActiveRecord::Base.send :include, HazWebhooks::Hook