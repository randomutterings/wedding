class Gift < ActiveRecord::Base
  attr_accessible :name, :amount, :status, :txn_id, :receiver_email,
                  :payer_email, :address_city, :address_country, :address_country_code, :address_name,
                  :address_state, :address_status, :address_street, :address_zip
  validates_presence_of :name, :amount
  validates_uniqueness_of :txn_id, :allow_nil => true
  
  def self.grand_total_in_cents
    self.all.map(&:amount).sum
  end

  def self.grand_total
    self.grand_total_in_cents.to_r.to_d / 100
  end

  def self.goal_in_cents
    (APP_CONFIG['gift_registry_goal'] * 100).to_i
  end
  
  def self.goal
    self.goal_in_cents.to_r.to_d / 100
  end
  
  def self.percentage_collected
    (self.grand_total_in_cents * 100) / self.goal_in_cents
  end
  
  def self.goal_left
    (self.goal_in_cents - self.grand_total_in_cents) / 100
  end
  
end
