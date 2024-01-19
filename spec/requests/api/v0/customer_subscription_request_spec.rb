require 'rails_helper'

describe "Create customer subscription" do
  it "receives parameters to create customer for subscription" do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    params = {
      "customer_id": "#{customer.id}",
      "subscription_id": "#{subscription.id}",
    }
    post '/api/v0/customer_subscriptions', params: params
    
    expect(response).to be_successful
    expect(response.status).to eq(201)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body).to eq({:success=>true, :message=>"You are now subscribed!"})
  end

  it "provides an error when missing params" do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    params = {
      "customer_id": "",
      "subscription_id": "#{subscription.id}",
    }
    post '/api/v0/customer_subscriptions', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Customer and subscription information are required.")
  end

  it "provides an error if custom subscription already exists." do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    params = {
      "customer_id": "#{customer.id}",
      "subscription_id": "#{subscription.id}",
    }
    post '/api/v0/customer_subscriptions', params: params

    params2 = {
      "customer_id": "#{customer.id}",
      "subscription_id": "#{subscription.id}",
    }
    post '/api/v0/customer_subscriptions', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("You are already enrolled in this subscription.")
  end

end

describe "Delete customer subscription" do
  it "receives parameters to delete customer from subscription" do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    cs = CustomerSubscription.create!(customer: customer, subscription: subscription)
    delete "/api/v0/customer_subscriptions/#{cs.id}"
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body).to eq({:success=>true, :message=>"You are now unsubscribed!"})
  end

  it "cannot delete a subscription that doesn't exist" do
    customer = FactoryBot.create(:customer)
    subscription = FactoryBot.create(:subscription)
    cs = CustomerSubscription.create!(customer: customer, subscription: subscription)
    delete "/api/v0/customer_subscriptions/#{cs.id + 1}"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("404")
    expect(response_body[:error].first[:detail]).to eq("Customer subscription not found.")
  end


end