class Load < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:new, :dispatched, :shipped], default: :new

  validates \
    :customer_name,
    :customer_location,
    :order_number,
    :origin_location,
    :product_description,
    :requested_date,
    :status,
    presence: true
  validates \
    :order_number,
    uniqueness: true
end
