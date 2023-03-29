require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to have_http_status(200)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:items)
      expect(merchant[:attributes][:items]).to be_an(Array)
    end

    # merchants.each do |merchant|
    #   merchant_name = Merchant.find(merchant[:id]).name
    #   expect(merchant_name).to eq(merchant[:attributes][:name])
    # end
  end
end