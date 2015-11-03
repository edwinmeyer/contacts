require 'rails_helper'

feature 'Contact management' do

  # Specify the New page field label and value to be filled in for each Contact record field
  contact_fields = [
    { label: 'First name', value: 'Quinn' },
    { label: 'Last name', value: 'Schleissheimer' },
    { label: 'Phone', value: '555-555-5555' },
    { label: 'Email', value: 'quinn@schleissheimer.com' }
  ]

  scenario "adds a new contact record" do
    visit root_path
    expect{
      click_link 'New'
      fill_in_contact_fields(contact_fields) # Fill in each of the contact fields
      click_button 'Create Contact'
    }.to change(Contact, :count).by(1)

    expect(page).to have_content 'Contact was successfully created'

    click_link 'Back'
    expect(current_path).to eq contacts_path

    # Find the contact fields values on the page
    contact_fields.each do |field|
      expect(page).to have_content field[:value]
    end
  end

end

# Fill in each of the contact fields
def fill_in_contact_fields(contact_fields)
  contact_fields.each do |field|
    fill_in field[:label], with: field[:value]
  end
end
