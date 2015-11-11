require 'rails_helper'

RSpec.describe ShipLoadEntry, type: :model do
  it { is_expected.to validate_presence_of :ship_date }
  it { is_expected.to validate_presence_of :weight_gross }

  describe 'attributes' do
    subject { described_class.new.attributes }
    its(:keys) { is_expected.to include :ship_date, :weight_gross }
  end
end
