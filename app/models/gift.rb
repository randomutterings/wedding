class Gift < ActiveRecord::Base
  attr_accessible :name, :amount, :status, :txn_id, :receiver_email,
                  :payer_email, :address_city, :address_country, :address_country_code, :address_name,
                  :address_state, :address_status, :address_street, :address_zip
  validates_presence_of :name, :amount
end
