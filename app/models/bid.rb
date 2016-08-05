class Bid < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :user_id, presence: true
  #validates :product_id, presence: true
  validates_numericality_of :bidded


 # validate :max, :min
  validates :product_id, presence: true

  scope :latest_bids, ->(n) { order(:created_at).last(5)}


  def max
    unless  bidded <= product.maximum_bid
      errors.add(:bidded, "must be less than or equal to #{product.maximum_bid}")
    end
  end

  def min
    unless bidded >= product.minimum_bid
      errors.add(:bidded, "must be greater than  or equal to#{product.minimum_bid}")
    end
  end



  private
    def r_max
      product.maximum_bid
    end
    def r_min
      product.minimum_bid
    end



end
