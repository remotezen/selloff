class Product < ActiveRecord::Base
  has_attached_file :image
  do_not_validate_attachment_file_type :image

  validates :description, presence:true
  validates :expiration, presence: true
  validates :name, presence:true, length: {in: 3..40}
  validate :expiration_date_cannot_be_in_the_past
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
