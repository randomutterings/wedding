class News < ActiveRecord::Base
  attr_accessible :title, :article, :published
end
