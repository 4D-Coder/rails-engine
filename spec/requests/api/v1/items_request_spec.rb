require "rails_helper"

describe "Item Requests" do
  it "sends a list of items" do
    items_list = create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(items).to have_key(:data)

    expect(items[:data].count).to eq(3)
    expect(items[:data][0][:attributes].count).to eq(4)
    expect(items[:data][0][:attributes][:name]).to eq(items_list.first.name)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

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
    
    expect(item[:data].length).to eq(3)
    expect(item[:data][:attributes].length).to eq(4)

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

  it 'can create a new, valid item' do
    item_params = attributes_for(:item, merchant_id: create(:merchant).id)
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to have_http_status(201)
    
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'sends an error response when invalid or missing information in JSON request' do
    item_params = attributes_for(:item, merchant_id: create(:merchant).id, name: nil, unit_price: "15.00")
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    require 'pry'; binding.pry
    expect(response).to have_http_status(400)
  end
end
