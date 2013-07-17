class CreateWebhooksTable < ActiveRecord::Migration
  def self.up
    create_table :webhooks, :force => true do |t|
      t.references :hook, :polymorphic => true
      t.string  :url
      t.string  :key
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :webhooks
  end
end