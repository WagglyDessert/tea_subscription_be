class Api::V0::CustomersController < ApplicationController

  def show 
    customer = Customer.find(params[:id])
    customer_subscriptions = CustomerSubscription.where(customer_id: customer.id)
    subscriptions = customer.subscriptions
    render json: CssSerializer.new(subscriptions)
  end

end