class Api::V0::CustomerSubscriptionsController < ApplicationController
  
  def create
    if !params[:customer_id].present? || !params[:subscription_id].present?
      render json: { error: [{status: "422", detail: 'Customer and subscription information are required.' }] }, status: :unprocessable_entity
    elsif CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
      render json: { error: [{status: "422", detail: 'You are already enrolled in this subscription.' }] }, status: :unprocessable_entity
    else
      cs = CustomerSubscription.new(user_params)
      if cs.save
        render json: { success: true, message: 'You are now subscribed!' }, status: :created
      else
        render json: { error: [{status: "422", detail: 'Something went wrong.' }] }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    begin
      cs = CustomerSubscription.find(params[:id])
      cs.destroy!
      render json: { success: true, message: 'You are now unsubscribed!' }, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: [{status: "404", detail: 'Customer subscription not found.' }] }, status: :not_found
    end
  end
  
  private
  def user_params
    params.permit(:customer_id, :subscription_id)
  end

end