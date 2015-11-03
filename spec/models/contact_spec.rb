require 'rails_helper'

describe Contact do

  it "has a valid factory that creates a contact with both first & last names" do
    expect(build(:contact)).to be_valid
  end

  # Invalid if either first or last name is omitted
  [:first_name, :last_name].each do |attr|
    it "is invalid without a #{attr}" do
      contact = build(:contact, attr => nil)
      contact.valid?
      expect(contact.errors[attr]).to include("can't be blank")
    end
  end
end
