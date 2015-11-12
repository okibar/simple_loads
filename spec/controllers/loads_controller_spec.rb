require 'rails_helper'

RSpec.describe LoadsController, type: :controller do
  describe 'GET edit' do
    before do
      allow(Load)
        .to receive(:find)
        .with(load.id.to_s)
        .and_return(load)

      get :edit, id: load.id
    end
    let(:load) { build_stubbed(:load) }

    it_behaves_like 'a successful request'
    it_behaves_like 'an edit'
  end

  describe 'GET index' do
    before { get :index }

    it_behaves_like 'a successful request'
    it_behaves_like 'an index'
  end

  describe 'driver select bug #1' do
    before do
      allow(Load)
        .to receive(:order)
        .with(:requested_date)
        .and_return(Load.where(id: drivers.map(&:id)).order(:id))

      get :index
    end
    let(:drivers) { [driver1, driver2] }
    let(:driver1) { FactoryGirl.create(:load, driver_name: 'driver1') }
    let(:driver2) { FactoryGirl.create(:load, driver_name: 'driver2') }
    it { expect(assigns(:drivers)).to eq(drivers.map(&:driver_name)) }
  end

  describe 'driver select bug #2' do
    before do
      allow(Load)
        .to receive(:order)
        .with(:requested_date)
        .and_return(Load.where(id: drivers.map(&:id)).order(:id))

      get :index, q: { 'driver_name_eq' => '', 'status_eq' => 'dispatched' }
    end
    let(:drivers) { [driver1, driver2] }
    let(:driver1) do
      FactoryGirl.create(:load, driver_name: 'driver1', status: :dispatched)
    end
    let(:driver2) do
      FactoryGirl.create(:load, driver_name: 'driver2', status: :shipped)
    end
    it { expect(assigns(:drivers)).to eq(drivers.map(&:driver_name)) }
  end

  describe 'GET new' do
    before { get :new }

    it_behaves_like 'a successful request'
    it_behaves_like 'a new'
  end

  describe 'GET show' do
    before do
      allow(Load)
        .to receive(:find)
        .with(load.id.to_s)
        .and_return(load)

      get :show, id: load.id
    end
    let(:load) { build_stubbed(:load) }

    it_behaves_like 'a successful request'
    it_behaves_like 'a show'
  end

  describe 'PATCH update' do
    before do
      patch :update, id: load.id, load: params
    end
    let(:load) { create(:load) }

    context 'when the parameters are not valid' do
      let(:params) { { customer_name: nil } }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit'
    end

    context 'when the parameters are valid' do
      let(:params) { attributes_for(:load) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(load_path(controller.load)) }
      it do
        is_expected.to set_flash[:notice].to(I18n.t('loads.update.success'))
      end
    end
  end

  describe 'POST create' do
    before do
      post :create, load: params
    end

    context 'when the parameters are valid' do
      let(:params) { attributes_for(:load) }

      it_behaves_like 'a redirect'
      it { is_expected.to redirect_to(load_path(controller.load)) }
      it do
        is_expected.to set_flash[:notice].to(I18n.t('loads.create.success'))
      end
    end
    context 'when the parameters are not valid' do
      let(:params) { {} }

      it_behaves_like 'a successful request'
      it_behaves_like 'a new'
    end
  end
end
