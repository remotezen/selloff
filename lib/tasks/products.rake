namespace :products do
  desc "Update sold status"
  task check_expiration: :environment do
    Product.all.each do |t| 
      if Time.current >= t.expiration
        t.update_attribute(:sold, true)  
      else
        t.update_attribute(:sold, false)
      end
        t.save!
      end
    end
  task add_line_item: :environment do
    Product.all.each do |t|
      if t.sold
        t.bids.each do |b|
          h = {
            quantity:1,
            price: b.bidded,
            user_id: b.user_id,
            product_id: b.product_id,
            bid_id: b.id
          }
          li = LineItem.create(h)
          li.save!
        end
      end
    end
  end
end
