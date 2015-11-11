class ShipLoadEntry < FormEntry
  attribute :weight_gross, String
  attribute :ship_date, String

  validates \
    :weight_gross,
    :ship_date,
    presence: true
end
