Rails.application.routes.draw do
  # mount Apidoco::Engine, at: "/docs"
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => '/cable'

  apipie
  namespace :api do
    namespace :v1 do
         resources :newsfeedfollows
     get 'status', to: 'status#index'
     resources :artcategory_skills
     resources :feedbacksessions
     resources :presenterquestionanswers #xv
     resources :presenterquestions  #xv
     resources :lessons  #xv
     resources :conversation_userskills  #xv
     resources :advisordates  #xv
     resources :project_skills  #x
     resources :user_skills  #x
     resources :projectadvisors  #x
     resources :reviewqueues
     resources :myadvisers  #x
     resources :avfeedbacklanes #x
     resources :projectresorts
     resources :artrelations  #x
     resources :artcategories  #x
     resources :messages  #x
     resources :projectfiles  #x
     resources :ratebacks  #x
     resources :parentcategories  #x
     resources :artfields
     resources :feedbacks  #x
     resources :ratings  #x
     resources :categories
     resources :projects #x
     resources :users #x
     resources :conversations #x
     resources :categoryrelations
     resources :skips #x
     resources :skills #x
     resources :projectquestionanswers #
     resources :arttagfields
     resources :arttags
     resources :tagfeedbacks
     resources :settings #
     resources :transactions #
     resources :invites #x
     resources :cards #x
     resources :stories #x
     resources :unconnected_payments, only: [:index, :create]

     post 'register_referral' => 'users#register_referral'
     post 'addusercard' => 'users#addcard'

     get 'projectsadmin' => 'projects#projectsadmin'
     get 'nextworksettings' => 'settings#nextworksettings'


     get 'userByEmail' => 'users#userByEmail'

     get 'advisors' => 'users#advisors'

     get 'presenterquestionanswersforrateflowproject' => 'presenterquestionanswers#presenterquestionanswersforrateflowproject'

     get 'projectsfeedback' => 'projects#project_for_feedback'
     get 'newsfeed_feedbacks' => 'newsfeed#feedbacks'
     get 'newsfeed_feedback_media_url' => 'newsfeed#media_url'
     get 'newsfeed_feedbacks_inspiring' => 'newsfeed#feedbacks_inspiring'

     get 'choosethebest_projects' => 'projects#choosethebest_projects'
     get 'my_choosethebest_projects' => 'projects#my_choosethebest_projects'

     get 'presenter_projects' => 'projects#presenter_projects'
     get 'presenter_questions' => 'projects#presenter_questions'

     get 'filetagclouds' => 'projects#filetagclouds'

     post 'create_stripe_payouts_account' => 'payouts#create_stripe_payouts_account'
     get 'get_stripe_balance' => 'payouts#get_stripe_balance'
     post 'create_intent_for_card_setup' => 'payouts#create_intent_for_card_setup'
     post 'create_payment_intent_for_paid_message' => 'payouts#create_payment_intent_for_paid_message'
     post 'create_payment_intent_for_paid_project_feedback' => 'payouts#create_payment_intent_for_paid_project_feedback'

     post 'create_intent_for_paid_project_feedback_for_non_connect_user' => 'payouts#create_intent_for_paid_project_feedback_for_non_connect_user'
     get 'get_dashboard_link' => 'payouts#get_dashboard_link'

     post 'filestack_webhook' => 'webhooks#filestack_webhook'
     post 'filestack_webhook_conversion' => 'webhooks#filestack_webhook_conversion'


     post 'testEmail' => 'users#testEmail'

     post 'payout' => 'payouts#payout'
     get 'fetch_connected_account' => 'payouts#fetch_connected_account'

     put 'update_rateback' =>  'projects#update_rateback'

     get 'advisor_user_profile/:id' => 'users#advisor_user_profile'
     get 'funnels/:id' => 'users#funnels'
     get 'funnelforstudent' => 'users#funnelforstudent'
     get 'funnelforadvisor' => 'users#funnelforadvisor'

     get 'fetch_payment_methods' => 'payouts#fetch_payment_methods'
     delete 'delete_stripe_account' => 'payouts#delete_stripe_account'

     get 'delete_all_ratebacks' => 'feedbacks#delete_all_ratebacks'

     get 'adviserprojects' => 'projects#adviserprojects'
     get 'studentprojects' => 'projects#studentprojects'

     post 'removemyadviser' => 'myadvisers#removemyadviser'

     get 'paidsession' => 'feedbacksessions#paidsession'

     put 'paidsessionpaid' => 'feedbacksessions#paidsessionpaid'

     post 'resend_confirmation' => 'users#resend_confirmation'

     get 'publicproject/:id' => 'projects#publicproject'
     get 'publicprojects' => 'projects#publicprojects'

     post 'addnewsfeedfollow' => 'newsfeedfollows#addnewsfeedfollow'
     post 'removenewsfeedfollow' => 'newsfeedfollows#removenewsfeedfollow'

     post 'submit_ideas' => 'newsfeedfollows#submit_ideas'
     post 'submit_support' => 'newsfeedfollows#submit_support'

     post 'add_to_reviewqueue' => 'reviewqueues#add_to_reviewqueue'
     post 'remove_from_reviewqueue' => 'reviewqueues#remove_from_reviewqueue'

     post 'create_room' => 'lessons#create_room'
     post 'close_room' => 'lessons#close_room'

     get 'my_pq_collections' => 'newsfeed#my_pq_collections'

     put 'artcategories' => 'artcategories#multi_update'
   end
  end

  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
       registrations:'device_registration',
       confirmations:'device_confirmation',
   }
end
