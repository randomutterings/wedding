class AddFieldsToGifts < ActiveRecord::Migration
  def self.up
    add_column :gifts, :status, :string
    add_column :gifts, :txn_id, :string
    add_column :gifts, :receiver_email, :string
    add_column :gifts, :payer_email, :string
    add_column :gifts, :address_city, :string
    add_column :gifts, :address_country, :string
    add_column :gifts, :address_name, :string
    add_column :gifts, :address_state, :string
    add_column :gifts, :address_status, :string
    add_column :gifts, :address_street, :string
    add_column :gifts, :address_zip, :string
  end

  def self.down
    remove_column :gifts, :address_zip
    remove_column :gifts, :address_street
    remove_column :gifts, :address_status
    remove_column :gifts, :address_state
    remove_column :gifts, :address_name
    remove_column :gifts, :address_country
    remove_column :gifts, :address_city
    remove_column :gifts, :payer_email
    remove_column :gifts, :receiver_email
    remove_column :gifts, :txn_id
    remove_column :gifts, :status
  end
end
