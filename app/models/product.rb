class Product < ActiveRecord::Base
  validates :description, presence:true
  validates :expiration, presence: true
  validates :name, presence:true, length: {in: 3..40}
  #validate :expiration_date_cannot_be_in_the_past
  has_many :product_attachments, dependent: :destroy
  accepts_nested_attributes_for :product_attachments, allow_destroy:true
  scope :expired, ->{where('expiration <= ?', Time.current)}

  belongs_to :user
  has_many :bids
  has_one :line_item, dependent: :destroy
  has_many :watches, dependent: :destroy


  def latest_bid_records(n)
     bids.order(:created_at).last(5)
  end

  def highest_bid
    bids.maximum(:bidded)
  end
  def highest_bid_object
    bids.max_by(&:bidded)
  end


  private
    def expiration_date_cannot_be_in_the_past
      if expiration.present? &&  expiration < Time.current
        errors.add(:expiration, "expiration date must in the future")
      end
    end
    def update_sold_after_expiration
      self.sold = true if expiration <= Time.current
      user = self.user
      max = bids.maximum(:bidded)
      ListItem.new(user_id: user.id,
                   product_id: self.id,
                    quantity: 1,
                    price:max
                  )

    end


end
