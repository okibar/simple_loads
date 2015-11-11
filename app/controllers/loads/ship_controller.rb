class Loads::ShipController < ApplicationController
  def update
    load = Load.find(params['load_id'].to_i)
    new_data = JSON.parse(params['ship-form-hidden'])
    if load && new_data
      load.ship(new_data['load']['ship_date'], new_data['load']['weight_gross'])
    end
    redirect_to loads_path
  end
end
