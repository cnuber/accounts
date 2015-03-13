require 'spec_helper'

feature 'Show error pages', js: true do
  scenario 'for internal server error 500' do
    with_error_pages do
      visit '/admin/raise_not_yet_implemented'
      expect(page.status_code).to eq(500)
      expect(page).to have_content('500 Internal Server Error')
      visit '/admin/raise_not_yet_implemented.json'
      expect(page.status_code).to eq(500)
      expect(JSON.parse(page.text)).to eq({'status' => 500, 'error' => 'internal_server_error'})
    end
  end

  scenario 'for not found 404' do
    with_error_pages do
      visit '/asdf'
      expect(page.status_code).to eq(404)
      expect(page).to have_content('404 Not Found')
      visit '/asdf.json'
      expect(page.status_code).to eq(404)
      expect(JSON.parse(page.text)).to eq({'status' => 404, 'error' => 'not_found'})
    end
  end

  scenario 'for forbidden 403' do
    with_error_pages do
      visit '/admin/raise_security_transgression'
      expect(page.status_code).to eq(403)
      expect(page).to have_content('403 Forbidden')
      visit '/admin/raise_security_transgression.json'
      expect(page.status_code).to eq(403)
      expect(JSON.parse(page.text)).to eq({'status' => 403, 'error' => 'forbidden'})
    end
  end
end
