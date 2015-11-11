require 'rails_helper'

feature 'user views a list of loads' do
  context 'when there are loads' do
    given!(:loads) { create_list(:load, 3) }

    scenario 'the loads are shown' do
      visit loads_path

      expect(page).to have_content(I18n.t('loads.index.title'))
      expect_load_row loads[0]
      expect_load_row loads[1]
      expect_load_row loads[2]
    end
  end

  context 'when there are no loads' do
    scenario 'no loads are shown' do
      visit loads_path

      expect(page).to have_content(I18n.t('loads.index.title'))
      expect(page).to have_content(I18n.t('loads.index.none_found'))
    end
  end
end

def expect_load_row(load)
  [:customer_name,
   :customer_location,
   :origin_location,
   :product_description,
   :requested_date,
   :status].each do |symbol|
    expect(page).to have_content(load.send(symbol))
  end
end
