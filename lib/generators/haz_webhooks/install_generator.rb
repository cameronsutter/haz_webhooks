require 'rails/generators'
require 'rails/generators/migration'

module HazWebhooks
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Creates a migration which creates a webhooks table"

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
     
    def self.next_migration_number(dirname) #:nodoc:
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end


    # Every method that is declared below will be automatically executed when the generator is run
    
    def create_migration_file
      migration_file = File.join(File.dirname(__FILE__), 'templates', 'migration.rb')
      migration_template migration_file, 'db/migrate/create_webhooks_table.rb'
    end
  end
end
