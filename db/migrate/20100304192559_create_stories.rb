class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.date :published_on
      t.timestamps
    end
  end
  
  def self.down
    drop_table :stories
  end
end
