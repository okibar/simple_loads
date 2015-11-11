class ShipLoad
  def initialize(load)
    @load = load
  end

  def ship(object)
    check_load_status

    @load.ship_date = object.ship_date
    @load.weight_gross = object.weight_gross
    @load.status = :shipped

    return false unless @load.save

    LoadMailer.shipped(load).deliver_now

    true
  end

  def load
    @load
  end

  def check_load_status
    fail I18n.t('ship_load.errors.new') \
      if load.status == :new

    fail I18n.t('ship_load.errors.shipped') \
      if load.status == :shipped

  end
end
