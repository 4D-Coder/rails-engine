require "rails_helper"

describe "Item Requests" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(items).to have_key(:data)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  # it "can get a single merchant by id" do
  #   id = create(:merchant).id

  #   get "/api/v1/merchants/#{id}"

  #   merchant = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to have_http_status(200)
  #   expect(merchant[:data]).to have_key(:id)
  #   expect(merchant[:data][:id]).to be_a(String)

  #   expect(merchant[:data]).to have_key(:type)
  #   expect(merchant[:data][:type]).to be_a(String)

  #   expect(merchant[:data]).to have_key(:attributes)
  #   expect(merchant[:data][:attributes]).to be_a(Hash)

  #   expect(merchant[:data][:attributes]).to have_key(:name)
  #   expect(merchant[:data][:attributes][:name]).to be_a(String)
  # end

  # it "will get an invalid id within the path and return a 404" do
  #   get "/api/v1/merchants/matildas_glass"

  #   merchant = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to have_http_status(404)
  #   expect(merchant[:error]).to eq("404, Not Found")
  # end
end
