class DispatchLoadEntry < FormEntry
  attribute :carrier_name, String
  attribute :driver_name, String
  attribute :weight_tare, String

  validates \
    :carrier_name,
    :driver_name,
    presence: true
end
