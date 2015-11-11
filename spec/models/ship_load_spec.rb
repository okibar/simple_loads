require 'rails_helper'

RSpec.describe ShipLoad, type: :model do
  describe '.new' do
    subject(:new) { described_class.new(load) }
    let(:load) { build_stubbed(:load) }

    its(:load) { is_expected.to eq (load) }
  end

  describe '#ship' do
    before do
      allow(LoadMailer).to receive(:shipped).and_return(mailer)
    end
    let(:mailer) { spy }
    let(:model) { described_class.new(load) }
    let(:load) do
      stubbed = build_stubbed(:load, status: :dispatched)
      allow(stubbed).to receive(:save) { save? }
      stubbed
    end
    let(:arguments) do
      OpenStruct.new(
        ship_date: Faker::Date.between(2.days.ago, Time.zone.today).to_s,
        weight_gross: Faker::Number.number(4))
    end
    subject(:ship) { model.ship(arguments) }

    context 'when the load has been shipped' do
      let(:load) { build_stubbed(:load, status: :shipped) }

      it do
        expect { ship }
          .to raise_error I18n.t('ship_load.errors.shipped')
      end
    end

    context 'when the load is new' do
      let(:load) { build_stubbed(:load, status: :new) }

      it do
        expect { ship }
          .to raise_error I18n.t('ship_load.errors.new')
      end
    end

    context 'when the save is successful' do
      let(:save?) { true }

      it { is_expected.to be true }
      it 'should send a dispatched notice' do
        subject

        expect(LoadMailer).to have_received(:shipped)
      end
    end

    context 'when the save is not successful' do
      let(:save?) { false }

      it { is_expected.to be false }
      it 'should not send a shipped notice' do
        subject

        expect(LoadMailer).to_not have_received(:shipped)
      end
    end

    describe '#load' do
      before { ship }

      let(:save?) { true }
      subject { model.load }

      its(:ship_date) { is_expected.to eq arguments.ship_date }
      its(:weight_gross) { is_expected.to eq arguments.weight_gross.to_i }
      its(:status) { is_expected.to eq :shipped }
    end
  end
end
