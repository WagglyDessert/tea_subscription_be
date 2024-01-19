require 'rails_helper'

describe "Create customer subscription" do
  it "receives parameters to create customer for subscription" do
    params = {
      "email": "whatever@example.com",
      "first_name": "Diana",
      "last_name": "Kemmer",
      "address": "4868 Rosenbaum Summit, Lake Benedict, PA 67970"
    }
    post '/api/v0/customers', params: params
    
    expect(response).to be_successful
    expect(response.status).to eq(201)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body).to eq({:success=>true, :message=>"You are now subscribed!"})
  end

  it "provides an error when missing a email, f_name, l_name, or address" do
    params = {
      "email": "whatever@example.com",
      "first_name": "Diana",
      "last_name": "Kemmer",
      "address": ""
    }
    post '/api/v0/customers', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Email, first name, last name, and address are required to enroll in a subscription.")
  end

  it "provides an error if email already exists." do
    customer = FactoryBot.create(:customer)
    params = {
      "email": "#{customer.email}",
      "first_name": "Diana",
      "last_name": "Kemmer",
      "address": "4868 Rosenbaum Summit, Lake Benedict, PA 67970"
    }
    post '/api/v0/customers', params: params

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
    delete "/api/v0/customers/#{customer.id}"
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body).to eq({:success=>true, :message=>"You are now unsubscribed!"})
  end

  it "cannot delete a subscription that doesn't exist" do
    customer = FactoryBot.create(:customer)
    delete "/api/v0/customers/#{customer.id + 1}"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("404")
    expect(response_body[:error].first[:detail]).to eq("Customer not found.")
  end
end