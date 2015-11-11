require 'rails_helper'

RSpec.describe Loads::ShipController, type: :controller do
  before do
    allow(Load)
      .to receive(:find)
      .with(load.id.to_s)
      .and_return(load)
  end
  let(:load) { build_stubbed(:load) }

  describe 'PATCH update' do
    before do
      allow(ShipLoad).to receive(:new) { service }

      patch :update, load_id: load.id, load: params
    end
    let(:ship?) { fail 'ship? has not been set' }
    let(:service) do
      ship_service = spy
      allow(ship_service).to receive(:ship) { ship? }
      allow(ship_service).to receive(:load) { load }
      ship_service
    end

    context 'when the details are not valid' do
      let(:params) { {} }

      it_behaves_like 'a redirect'
      it_behaves_like 'load index'

      it do
        is_expected
          .to set_flash[:alert].to(I18n.t('loads.ship.update.failure'))
      end
    end

    context 'when the ship is successful' do
      let(:ship?) { true }
      let(:params) { %[ { 
        "ship_date": "#{Faker::Date.between(2.days.ago, Date.today)}",
        "weight_gross": "#{Faker::Number.number(4)}" 
      } ] }

      it_behaves_like 'a redirect'
      it_behaves_like 'load index'
      it do
        is_expected
          .to set_flash[:notice].to(I18n.t('loads.ship.update.success'))
      end
    end

    context 'when the ship is not successful' do
      let(:ship?) { false }
      let(:params) { %[ { 
        "ship_date": "#{Faker::Date.between(2.days.ago, Date.today)}",
        "weight_gross": "#{Faker::Number.number(4)}" 
      } ] }

      it_behaves_like 'a redirect'
      it_behaves_like 'load index'
      it do
        is_expected
          .to set_flash[:alert].to(I18n.t('loads.ship.update.failure'))
      end
    end
  end
end
