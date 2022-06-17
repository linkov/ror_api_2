class Api::V1::UnconnectedPaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    unconnected_payments = current_user.unconnected_payments

    render json: unconnected_payments
  end

  def create
    unconnected_payment = UnconnectedPayment.new(unconnected_payment_params)
    unconnected_payment.student_id = current_user.id

    if unconnected_payment.save
      render status: :no_content
    else
      render json: unconnected_payment.errors, status: :unprocessable_entity
    end
  end

  private

  def unconnected_payment_params
    params.require(:unconnected_payment).permit(:user_id, :project_id)
  end
end
