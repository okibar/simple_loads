module Loads
  class DispatchController < ApplicationController
    def edit
      render_edit
    end

    def quickupdate
      quickentry
      update
    end

    def update
      render_edit and return unless entry.valid?

      if dispatch_load
        redirect_to load_path(load), notice: t('.success')
      else
        flash[:alert] = t('.failure')

        render_edit
      end
    end

    def load
      @load ||= find_load
    end

    def entry
      @entry ||= build_entry(entry_params)
    end

    def quickentry
      @entry = build_entry(quickentry_params)
    end

    protected

    def render_edit
      render :edit, locals: { entry: entry, load: load }
    end

    def dispatch_load
      DispatchLoad.new(load).dispatch(entry)
    end

    def find_load
      Load.find(params[:load_id])
    end

    def build_entry(params)
      DispatchLoadEntry.new(params)
    end

    def entry_params
      return {} if params[:entry].nil? || params[:entry].empty?
      params
        .require(:entry)
        .permit(:carrier_name,
                :driver_name)
    end

    def quickentry_params
      return {} if params[:entry].nil? || params[:entry].empty?
      entry_hash = JSON.parse(params.require(:entry))
      entry_hash[:driver_name] = params[:driver_name]
      entry_hash[:carrier_name] = params[:carrier_name]
      subparams = ActionController::Parameters.new(entry_hash)

      subparams
        .permit(:driver_name,
                :carrier_name,
                :weight_tare)
    end
  end
end
