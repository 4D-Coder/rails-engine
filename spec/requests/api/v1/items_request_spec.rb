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
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can get a single item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to have_http_status(200)

    expect(item[:data]).to be_a(Hash)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data]).to have_key(:type)
    expect(item[:data][:type]).to be_a(String)

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a(Hash)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "will get an invalid id within the path and return a 404" do
    get "/api/v1/items/random_strain"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(merchant[:error]).to eq("404, Not Found")
  end
end
