require 'rails_helper'

describe "Third Places API Endpoint" do
  it "sends a list of third places" do
    create_list(:third_space, 5)

    get '/api/v1/third_spaces'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    third_spaces = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(third_spaces.count).to eq(5)

    third_spaces.each do |space|
      expect(space).to have_key(:id)

      expect(space).to have_key(:type)
      expect(space[:type]).to be_a(String)
      expect(space[:type]).to eq("third_space")

      expect(space).to have_key(:attributes)
      expect(space[:attributes]).to be_an(Hash)

      expect(space[:attributes]).to have_key(:yelp_id)
      expect(space[:attributes][:yelp_id]).to be_a(String)

      expect(space[:attributes]).to have_key(:name)
      expect(space[:attributes][:name]).to be_a(String)

      expect(space[:attributes]).to have_key(:address)
      expect(space[:attributes][:address]).to be_a(String)

      expect(space[:attributes]).to have_key(:rating)
      expect(space[:attributes][:rating]).to be_a(Float)

      expect(space[:attributes]).to have_key(:phone)
      expect(space[:attributes][:phone]).to be_a(String)

      expect(space[:attributes]).to have_key(:photos)
      expect(space[:attributes][:photos]).to be_a(Array)

      expect(space[:attributes]).to have_key(:lat)
      expect(space[:attributes][:lat]).to be_a(Float)

      expect(space[:attributes]).to have_key(:lon)
      expect(space[:attributes][:lon]).to be_a(Float)

      expect(space[:attributes]).to have_key(:tags)
      expect(space[:attributes][:tags]).to be_a(Array)

      expect(space[:attributes]).to have_key(:price)
      expect(space[:attributes][:price]).to be_a(String)

      expect(space[:attributes]).to have_key(:hours)
      expect(space[:attributes][:hours]).to be_a(String)

      expect(space[:attributes]).to have_key(:category)
      expect(space[:attributes][:category]).to be_a(String)

      expect(space[:attributes]).to have_key(:open_now)
      expect(space[:attributes][:open_now]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  it "sends a specific third place" do
    create_list(:third_space, 5)

    id = ThirdSpace.all.first.id

    get "/api/v1/third_spaces/#{id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    space = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(space).to have_key(:id)

    expect(space).to have_key(:type)
    expect(space[:type]).to be_a(String)
    expect(space[:type]).to eq("third_space")

    expect(space).to have_key(:attributes)
    expect(space[:attributes]).to be_an(Hash)

    expect(space[:attributes]).to have_key(:yelp_id)
    expect(space[:attributes][:yelp_id]).to be_a(String)

    expect(space[:attributes]).to have_key(:name)
    expect(space[:attributes][:name]).to be_a(String)

    expect(space[:attributes]).to have_key(:address)
    expect(space[:attributes][:address]).to be_a(String)

    expect(space[:attributes]).to have_key(:rating)
    expect(space[:attributes][:rating]).to be_a(Float)

    expect(space[:attributes]).to have_key(:phone)
    expect(space[:attributes][:phone]).to be_a(String)

    expect(space[:attributes]).to have_key(:photos)
    expect(space[:attributes][:photos]).to be_a(Array)

    expect(space[:attributes]).to have_key(:lat)
    expect(space[:attributes][:lat]).to be_a(Float)

    expect(space[:attributes]).to have_key(:lon)
    expect(space[:attributes][:lon]).to be_a(Float)

    expect(space[:attributes]).to have_key(:tags)
    expect(space[:attributes][:tags]).to be_a(Array)

    expect(space[:attributes]).to have_key(:price)
    expect(space[:attributes][:price]).to be_a(String)

    expect(space[:attributes]).to have_key(:hours)
    expect(space[:attributes][:hours]).to be_a(String)

    expect(space[:attributes]).to have_key(:category)
    expect(space[:attributes][:category]).to be_a(String)

    expect(space[:attributes]).to have_key(:open_now)
    expect(space[:attributes][:open_now]).to be_a(TrueClass).or be_a(FalseClass)
  end

  it "can create a new third space" do
    space_params = ({ id: 126,
                    yelp_id: "Juana Bea",
                    name: "Barton Inc",
                    address: "8761 DuBuque Lights",
                    rating: 37.47,
                    phone: "7842541779",
                    photos: [],
                    lat: 10.08,
                    lon: 79.34,
                    price: "FT\u{63F19}",
                    hours: "Olive Hoyl",
                    open_now: false,
                    category: "German",
                    tags: ["happy", "studious"]})
     
    expect(ThirdSpace.all.length).to eq(0)

    post api_v1_third_spaces_path, params: space_params
    
    space = ThirdSpace.last 

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(ThirdSpace.all.length).to eq(1)

    expect(space.name).to eq(space_params[:name])
    expect(space.address).to eq(space_params[:address])
    expect(space.rating).to eq(space_params[:rating])
    expect(space.phone).to eq(space_params[:phone])
    expect(space.lat).to eq(space_params[:lat])
    expect(space.lon).to eq(space_params[:lon])
    expect(space.price).to eq(space_params[:price])
    expect(space.hours).to eq(space_params[:hours])
    expect(space.open_now).to eq(space_params[:open_now])
    expect(space.category).to eq(space_params[:category])
    expect(space.tags).to eq(space_params[:tags])
  end
end