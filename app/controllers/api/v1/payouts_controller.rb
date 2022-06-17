class Api::V1::PayoutsController < ApplicationController
  before_action :authenticate_user!

  def fetch_connected_account

    acc = Stripe::Account.retrieve(current_user.stripe_user_id)
    render json: acc

  end

  def payout
    balance = Stripe::Balance.retrieve({
      stripe_account: current_user.stripe_user_id,
    })

    available_amount = balance[:available][0][:amount]
    currency = balance[:available][0][:currency]

    if available_amount < 3000
      return render json: { message: "Minimum withdrawal amount 30 #{currency}" }, status: :bad_request
    end

    Stripe::Payout.create({
      amount: available_amount,
      currency: currency,
      description: 'For advisory services.'
    }, stripe_account: current_user.stripe_user_id)

    render status: :no_content
  end


  def delete_stripe_account
    begin
      Stripe::Account.delete(current_user.stripe_user_id)
    rescue Stripe::InvalidRequestError
      nil
    rescue Stripe::PermissionError
      nil
    end

    current_user.clean_stripe!
  end

  def create_stripe_payouts_account
    response = Stripe::OAuth.token({
      grant_type: 'authorization_code',
      code: params[:code]
    })
    connected_account_id = response.stripe_user_id
    current_user.stripe_user_id = connected_account_id
    current_user.save!

    res = Stripe::Account.update(
      current_user.stripe_user_id,
      {settings: {payouts: {schedule: {interval: 'manual',} }}},
    )

    render json: res

  end

  def fetch_payment_methods
    if current_user.stripe_customer_id == nil
      customer = Stripe::Customer.create(email: current_user.email)
      current_user.stripe_customer_id = customer['id']
      current_user.save!
      render json: []

    else

      methods = Stripe::PaymentMethod.list({
        customer: current_user.stripe_customer_id,
        type: 'card',
      })
      render json: methods

    end


  end


  def create_payment_intent_for_paid_project_feedback
    to_stripe_user_amount = Integer(params[:inspiring_rate] * 100);
    to_stripe_user = User.find(params[:user_id])
    desc = 'For a helpful review'

    if current_user.stripe_customer_id == nil
      customer = Stripe::Customer.create(email: current_user.email)
      current_user.stripe_customer_id = customer['id']
      current_user.save!
      create_payment_intent_for_new_card(to_stripe_user, to_stripe_user_amount, desc)

      return
    end

    payment_methods = Stripe::PaymentMethod.list(
          customer: current_user.stripe_customer_id,
          type: 'card'
        )

    if payment_methods.count == 0
      create_payment_intent_for_new_card(to_stripe_user, to_stripe_user_amount, desc)

      return
    end

    payment_intent = Stripe::PaymentIntent.create({
      amount: to_stripe_user_amount,
      currency: 'eur',
      application_fee_amount: general_price(to_stripe_user_amount),
      customer: current_user.stripe_customer_id,
      capture_method: 'automatic',
      payment_method: payment_methods.data[0].id,
      off_session: true,
      confirm: true,
      metadata: {
        user: to_stripe_user.name,
        created: DateTime.current
      },
      description: 'For a helpful review',
      transfer_data: {
        destination: to_stripe_user_.stripe_user_id,
      },
    })

    render json: payment_intent
  end

  def create_payment_intent_for_new_card(to_stripe_payout_user, amount, desc)
    payment_intent = Stripe::PaymentIntent.create({
      amount: amount,
      currency: 'eur',
      application_fee_amount: general_price(amount),
      customer: current_user.stripe_customer_id,
      capture_method: 'automatic',
      description: desc,
      metadata: {
        user: to_stripe_payout_user.name,
        created: DateTime.current
      },
      transfer_data: {
        destination: to_stripe_payout_user.stripe_user_id,
      },
    })

    render json: payment_intent
  end

  def create_payment_intent_for_paid_message
    message = params[:message]
    to_stripe_user= User.find(message[:user_id])
    to_stripe_user_amount = Integer(message[:paymentrequestamount])
    desc = 'Consultation fee'

    if current_user.stripe_customer_id == nil
      customer = Stripe::Customer.create(email: current_user.email)
      current_user.stripe_customer_id = customer['id']
      current_user.save!
      create_payment_intent_for_new_card(to_stripe_user, to_stripe_user_amount, desc)

      return
    end

    payment_methods = Stripe::PaymentMethod.list(
          customer: current_user.stripe_customer_id,
          type: 'card'
        )

    if payment_methods.count == 0
      create_payment_intent_for_new_card(to_stripe_user, to_stripe_user_amount, desc)

      return
    end

    payment_intent = Stripe::PaymentIntent.create({
      amount: to_stripe_user_amount,
      currency: 'eur',
      application_fee_amount: general_price(to_stripe_user_amount),
      capture_method: 'automatic',
      payment_method: payment_methods.data[0].id,
      customer: current_user.stripe_customer_id,
      confirm: true,
      off_session: true,
      description: desc,
      metadata: {
        user: to_stripe_user.name,
        created: DateTime.current
      },
      transfer_data: {
        destination: to_stripe_user.stripe_user_id,
      },
    })

    render json: payment_intent
  end


  def get_dashboard_link
    link = Stripe::Account.create_login_link(
      current_user.stripe_user_id
    ).to_hash
    link_student = { billing_url: get_billing_portal.try(:url) }

    render json: link.merge(link_student)
  end

  def get_stripe_balance

    balance = Stripe::Balance.retrieve({
      stripe_account: current_user.stripe_user_id,
    })

    puts balance


    render json:  {
      available_amount: balance[:available][0][:amount],
      pending_amount: balance[:pending][0][:amount],
      currency: balance[:available][0][:currency]
    }
  end

  private

  def get_billing_portal
    return unless current_user.stripe_customer_id

    Stripe::BillingPortal::Session.create({ customer: current_user.stripe_customer_id })
  end

  def general_price(amount, app_percent = 30)
    ((amount / 100) * (app_percent + 2.9) + 30).ceil
  end
end
