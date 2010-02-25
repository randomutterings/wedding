class AddPhotoToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :photo_file_name,    :string
    add_column :members, :photo_content_type, :string
    add_column :members, :photo_file_size,    :integer
    add_column :members, :photo_updated_at,   :datetime
  end

  def self.down
    remove_column :members, :photo_file_name
    remove_column :members, :photo_content_type
    remove_column :members, :photo_file_size
    remove_column :members, :photo_updated_at
  end
end