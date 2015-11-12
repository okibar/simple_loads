class LoadsController < ApplicationController
  def create
    if load.save
      redirect_to load_path(load), notice: t('.success')
    else
      render_new
    end
  end

  def edit
    render_edit
  end

  def index
    render_index
  end

  def new
    render_new
  end

  def show
    render_show
  end

  def update
    if load.update_attributes(load_params)
      redirect_to load_path(load), notice: t('.success')
    else
      render_edit
    end
  end

  def load
    @load ||= params[:id] ? find_load : build_load
  end

  protected

  def drivers
    @drivers ||= loads.map(&:driver_name).uniq || []
  end

  def loads
    @loads ||= Load.order(:requested_date)
  end

  def search
    @search ||= loads.search(params[:q])
  end

  def find_load
    Load.find(params[:id])
  end

  def build_load
    Load.new(load_params)
  end

  def load_params
    return {} if params[:load].nil? || params[:load].empty?

    params
      .require(:load)
      .permit(:customer_name,
              :customer_location,
              :carrier_name,
              :driver_name,
              :order_number,
              :origin_location,
              :product_description,
              :requested_date,
              :ship_date,
              :status,
              :weight_gross,
              :weight_net,
              :weight_tare)
  end

  def render_new
    render :new, locals: { load: load }
  end

  def render_edit
    render :edit, locals: { load: load }
  end

  def render_index
    render :index,
           locals: { drivers: drivers, loads: search.result, search: search }
  end

  def render_show
    render :show, locals: { load: load }
  end
end
