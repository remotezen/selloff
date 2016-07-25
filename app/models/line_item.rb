class LineItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :bid
end
