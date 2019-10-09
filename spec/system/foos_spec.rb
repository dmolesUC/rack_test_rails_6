require 'rails_helper'

RSpec.describe "Foos", type: :system do
  before do
    driven_by(:rack_test, using: :rack_test)
  end

  describe 'show' do
    it 'shows a page' do
      visit '/foo/show'
      expect(page).to have_content('Foo')
    end
  end
end
