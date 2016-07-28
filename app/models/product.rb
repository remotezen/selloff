class Product < ActiveRecord::Base
  validates :description, presence:true
  validates :expiration, presence: true
  validates :name, presence:true, length: {in: 3..40}
  validate :expiration_date_cannot_be_in_the_past
  has_many :product_attachments, dependent: :destroy
  accepts_nested_attributes_for :product_attachments, allow_destroy:true


  belongs_to :user
  has_many :bids


  def latest_bid_records(n)
     bids.order(:created_at).last(5)
  end


  def highest_bid
    bids.maximum(:bidded)
  end

  private
    def expiration_date_cannot_be_in_the_past
      if expiration.present? &&  expiration < Date.today
        errors.add(:expiration, "expiration date must in the future")
      end
    end


end
