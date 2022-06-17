class DeviceRegistrationController < DeviseTokenAuth::RegistrationsController


  def create
    super do |resource|
      resource.referral_token = SecureRandom.hex(5)
      resource.sharetoken = SecureRandom.hex(5)
      resource.advisorrate = 5
      customer = Stripe::Customer.create
      resource.stripe_customer_id = customer['id']
      resource.save!

      #UsersMailer.welcome_email(resource.id).deliver_now


    end
  end

end
