class Api::V1::WebhooksController < ApplicationController

  def filestack_webhook_conversion
    webhook = params


    if  webhook[:text][:results].values.length > 1

      url = webhook[:text][:results].values[1][:data][:data][:url]
      thumb =  webhook[:text][:results].values[1][:data][:data][:thumb]
      jobID = webhook[:text][:jobid]

      convertion = Avconversion.new(:url => url, :thumb => thumb, :jobid => jobID)
      convertion.save!

    end



    # Bugsnag.notify(webhook)
  end

  def filestack_webhook
    # webhook = params
    # url = webhook[:data][:url]
    # thumb = webhook[:data][:thumb]
    # jobID = webhook[:uuid]
    #
    # Bugsnag.notify(webhook)



  end

  def create_charge
  end


  def get_dashboard_link
    link = Stripe::Account.create_login_link(
      current_user.stripe_user_id
    )


    render json: link

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

end
