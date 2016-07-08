class Bid < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates_numericality_of :bidded, 
    on: :create
  validate :r_maximum
  validate :r_minimum
 
  def r_maximum
    unless bidded <= self.product.maximum_bid
      errors.add(:bidded, "must be less than or equal to #{self.product.maximum_bid}")
    end
  end
  
  def r_minimum
    unless bidded >= self.product.maximum_bid
      errors.add(:bidded, "must be greater than  or equal to#{self.product.minimum_bid}")
    end
  end
end
