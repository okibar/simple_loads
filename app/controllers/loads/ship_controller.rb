class Loads::ShipController < ApplicationController
  def update
    load = Load.find(params['load_id'].to_i)
    new_data = JSON.parse(params['ship-form-hidden'])
    if load && new_data
      load.ship(date: new_data['date'], weight: new_data['scale_weight'])
    end
    redirect_to loads_path
  end
end
