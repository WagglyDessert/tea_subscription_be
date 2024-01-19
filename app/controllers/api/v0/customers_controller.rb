class Api::V0::CustomersController < ApplicationController

  def create
    if !params[:email].present? || !params[:first_name].present? || !params[:last_name].present? || !params[:address].present?
      render json: { error: [{status: "422", detail: 'Email, first name, last name, and address are required to enroll in a subscription.' }] }, status: :unprocessable_entity
    elsif Customer.find_by_email(params[:email])
      render json: { error: [{status: "422", detail: 'You are already enrolled in this subscription.' }] }, status: :unprocessable_entity
    else
      customer = Customer.new(user_params)
      if customer.save
        render json: { success: true, message: 'You are now subscribed!' }, status: :created
      else
        render json: { error: [{status: "422", detail: 'Something went wrong.' }] }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    begin
      customer = Customer.find(params[:id])
      customer.destroy!
      render json: { success: true, message: 'You are now unsubscribed!' }, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: [{status: "404", detail: 'Customer not found.' }] }, status: :not_found
    end
  end
  
  private
  def user_params
    params.permit(:email, :first_name, :last_name, :address)
  end

end