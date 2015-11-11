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

  def ship(date = nil, weight = nil)
    self.ship_date = date || raise('Invalid Date')
    self.weight_gross = weight.to_i || raise('Invalid Weight')
    self.status = :shipped
    save!
  end
end
