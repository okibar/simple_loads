class Loads::ShipController < ApplicationController
  def update
    unless entry.valid?
      redirect_to loads_path, alert: t('.failure')
      return
    end

    if ship_load
      redirect_to loads_path, notice: t('.success')
    else
      redirect_to loads_path, alert: t('.failure')
    end
  end

  def load
    @load ||= find_load
  end

  def entry
    @entry ||= build_entry
  end

  protected

  def ship_load
    ShipLoad.new(load).ship(entry)
  end

  def find_load
    Load.find(params[:load_id])
  end

  def build_entry
    ShipLoadEntry.new(entry_params)
  end

  def entry_params
    return {} if params[:load].nil? || params[:load].empty?

    load_hash = JSON.parse(params.require(:load))
    subparams = ActionController::Parameters.new(load_hash)

    subparams
      .permit(:ship_date,
              :weight_gross)
  end
end
