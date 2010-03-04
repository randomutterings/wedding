class Gift < ActiveRecord::Base
  attr_accessible :name, :amount
  validates_presence_of :name, :amount
end
