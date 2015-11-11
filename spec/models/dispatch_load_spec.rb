require 'rails_helper'

RSpec.describe DispatchLoad, type: :model do
  describe '.new' do
    subject(:new) { described_class.new(load) }
    let(:load) { build_stubbed(:load) }

    its(:load) { is_expected.to eq load }
  end

  describe '#dispatch' do
    before do
      allow(LoadMailer).to receive(:dispatched).and_return(mailer)
    end
    let(:mailer) { spy }
    let(:model) { described_class.new(load) }
    let(:load) do
      stubbed = build_stubbed(:load)
      allow(stubbed).to receive(:save) { save? }
      stubbed
    end
    let(:arguments) do
      OpenStruct.new(carrier_name: Faker::Company.name,
                     driver_name: Faker::Name.name)
    end
    subject(:dispatch) { model.dispatch(arguments) }

    context 'when the load has been dispatched' do
      let(:load) { build_stubbed(:load, status: :dispatched) }

      it do
        expect { dispatch }
          .to raise_error I18n.t('dispatch_load.errors.dispatched')
      end
    end

    context 'when the load has been shipped' do
      let(:load) { build_stubbed(:load, status: :shipped) }

      it do
        expect { dispatch }
          .to raise_error I18n.t('dispatch_load.errors.shipped')
      end
    end

    context 'when the save is successful' do
      let(:save?) { true }

      it { is_expected.to be true }
      it 'should send a dispatched notice' do
        subject

        expect(LoadMailer).to have_received(:dispatched)
      end
    end

    context 'when the save is not successful' do
      let(:save?) { false }

      it { is_expected.to be false }
      it 'should not send a dispatched notice' do
        subject

        expect(LoadMailer).to_not have_received(:dispatched)
      end
    end

    describe '#load' do
      before { dispatch }

      let(:save?) { true }
      subject { model.load }

      its(:carrier_name) { is_expected.to eq arguments.carrier_name }
      its(:driver_name) { is_expected.to eq arguments.driver_name }
      its(:status) { is_expected.to eq :dispatched }
    end
  end
end
