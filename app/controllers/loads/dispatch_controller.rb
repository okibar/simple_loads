module Loads
  class DispatchController < ApplicationController
    def edit
      render_edit
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
      @entry ||= build_entry
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

    def build_entry
      DispatchLoadEntry.new(entry_params)
    end

    def entry_params
      return {} if params[:entry].nil? || params[:entry].empty?

      params
        .require(:entry)
        .permit(:carrier_name,
                :driver_name)
    end
  end
end
