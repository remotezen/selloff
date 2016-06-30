class Product < ActiveRecord::Base
  has_attached_file :image
  do_not_validate_attachment_file_type :image

  belongs_to :user_id
end
