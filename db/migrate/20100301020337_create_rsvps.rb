class CreateRsvps < ActiveRecord::Migration
  def self.up
    create_table :rsvps do |t|
      t.integer :guest_id
      t.integer :event_id
      t.integer :attending

      t.timestamps
    end
  end

  def self.down
    drop_table :rsvps
  end
end
