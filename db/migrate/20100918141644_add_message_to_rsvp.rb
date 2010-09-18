class AddMessageToRsvp < ActiveRecord::Migration
  def self.up
    add_column :rsvps, :message, :text
  end

  def self.down
    remove_column :rsvps, :message
  end
end
