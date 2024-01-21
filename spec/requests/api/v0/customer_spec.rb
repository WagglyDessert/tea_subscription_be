require 'rails_helper'

describe "Indexes a customers subscriptions" do
  it "shows a list of subscriptions" do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    subscription2 = FactoryBot.create(:subscription)
    cs = CustomerSubscription.create!(customer: customer, subscription: subscription)
    cs2 = CustomerSubscription.create!(customer: customer, subscription: subscription2)
    get "/api/v0/customers/#{customer.id}"
    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:data]).to be_a(Array)
    response_body[:data].each do |r|
      expect(r).to have_key(:id)
      expect(r).to have_key(:type)
      expect(r[:type]).to eq("css")
      expect(r[:attributes]).to be_a(Hash)
      expect(r[:attributes]).to have_key(:title)
      expect(r[:attributes][:title]).to be_a(String)
      expect(r[:attributes][:title]).to eq(subscription.title).or(eq(subscription2.title))
      expect(r[:attributes]).to have_key(:price)
      expect(r[:attributes][:price]).to be_a(Float)
      expect(r[:attributes][:price]).to eq(subscription.price).or(eq(subscription2.price))
      expect(r[:attributes]).to have_key(:status)
      expect(r[:attributes][:status]).to be_a(String)
      expect(r[:attributes][:status]).to eq(subscription.status).or(eq(subscription2.status))
      expect(r[:attributes]).to have_key(:frequency)
      expect(r[:attributes][:frequency]).to be_a(Integer)
      expect(r[:attributes][:frequency]).to eq(subscription.frequency).or(eq(subscription2.frequency))
    end
  end

end