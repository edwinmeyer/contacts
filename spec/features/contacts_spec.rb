require 'rails_helper'

feature 'Contact management' do

  scenario "the root path displays the Content index page" do
    visit root_path
    expect(page).to have_content 'Contacts'
    expect(page).to have_content 'Filter By Name'
  end

  # Specify the New page field label and value to be filled in for each Contact record field
  contact_fields = [
    { label: 'First name', value: 'Quinn' },
    { label: 'Last name', value: 'Schleissheimer' },
    { label: 'Phone', value: '555-555-5555' },
    { label: 'Email', value: 'quinn@schleissheimer.com' }
  ]

  scenario "adds a new contact record" do
    expect{
      create_content_record(contact_fields)
    }.to change(Contact, :count).by(1)

    expect(page).to have_content 'Contact was successfully created'

    click_link 'Back'
    expect(current_path).to eq contacts_path

    # Find the contact fields values on the page
    contact_fields.each do |field|
      expect(page).to have_content field[:value]
    end
  end

  scenario "edits a contact record" do
    create_content_record(contact_fields)
    click_link 'Edit'

    expect(current_path).to eq edit_contact_path(Contact.first)
    fill_in 'Phone', with: '444-444-4444'
    click_button 'Update Contact'
    expect(page).to have_content 'Contact was successfully updated'
    expect(page).to have_content '444-444-4444'

    click_link 'Back'
    expect(current_path).to eq contacts_path
  end

  scenario "deletes a contact record" do
    create_content_record(contact_fields)
    click_link 'Back'
    expect(current_path).to eq contacts_path

    expect{
      click_link 'Delete'
    }.to change(Contact, :count).by(-1)
  end

  scenario "deletes all contact records" do
    create_content_record(contact_fields)
    create_content_record(contact_fields)
    click_link 'Back'
    expect(current_path).to eq contacts_path

    expect{
      click_link 'Delete All'
    }.to change(Contact, :count).by(-2)
  end

end

# Fill in each of the contact fields
def fill_in_contact_fields(contact_fields)
  contact_fields.each do |field|
    fill_in field[:label], with: field[:value]
  end
end

def create_content_record(contact_fields)
  visit contacts_path
  click_link 'New'
  fill_in_contact_fields(contact_fields) # Fill in each of the contact fields
  click_button 'Create Contact'
end
