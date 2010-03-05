class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :permalink
      t.text :content
      t.timestamps
    end
    Page.create :name => "Home Page", :permalink => "home", :content => "This is the home page."
    Page.create :name => "Gifts Page", :permalink => "gifts", :content => "This is the gifts page."
  end
  
  def self.down
    drop_table :pages
  end
end
