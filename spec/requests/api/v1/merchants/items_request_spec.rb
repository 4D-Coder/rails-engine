require 'rails_helper'

describe "Merchant Items API" do
  it "sends a list of merchant items" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
  end
end