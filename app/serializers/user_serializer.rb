class UserSerializer < ActiveModel::Serializer
  attributes :inspiring_rates_count, :time_zone,  :isteam, :profileimage, :sharetoken, :queuedprojects, :showtutorials, :id, :lang, :adviserIDs, :project_ids, :email, :advisorrate, :image, :imagethumb, :stripe_customer_id, :stripe_user_id, :admin, :uid, :referral_token, :website, :city, :showimage, :showcity, :showname, :showwebsite, :name, :open_cards
  has_many :myadvisers
  has_many :advisordates
end

def inspiring_rates_count
  ratings = Rating.where(:user_id => id )
  feedbacks = Feedback.where(:rating_id => ratings)
  inspiring = Rateback.where(:feedback_id => feedbacks, :value => 5).count
end

def queuedprojects
  reviewqueues.collect(&:project_id)
end

def imagethumb
  if image
    return 'https://cdn.filestackcontent.com/output=format:pjpg/rotate=deg:"exif"/resize=height:160/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+image

  end
end

def adviserIDs
  myadvisers.collect(&:adviserid)
end

def project_ids
  object.projects.collect(&:id)
end

def open_cards
  user_projects = Project.where(:user_id => id)
  ratings_received = Rating.where(:project => user_projects)
  feedbacks_received = Feedback.where(:rating_id => ratings_received)
  ratebacks_given = Rateback.where(:feedback_id => feedbacks_received)

  return (feedbacks_received.count - ratebacks_given.count) > 0

end

# def free_tier_left
#
#   cap = Setting.where(:name => 'charges_cap').first.value
#   now = DateTime.current
#   start_time = now.beginning_of_month
#   money_transactions_this_month = Transaction.where(:transactiontype => 'top_up',created_at: start_time..Time.now )
#   if money_transactions_this_month.count > 0
#     cap - money_transactions_this_month.collect(&:value).sum
#   else
#     cap
#   end
#
# end

# def ratescore
#   user_projects = Project.where(:user_id => id)
#   ratings_given_by_user = Rating.where(:user_id => id).select("DISTINCT project_id").count
#   ratings_given_to_user = Rating.where(:project => user_projects).select("DISTINCT user_id").count
#   ratings_given_by_user - ratings_given_to_user
# end

# def free_tier_complete
#
#   cap = Setting.where(:name => 'charges_cap').first.value
#   now = DateTime.current
#   start_time = now.beginning_of_month
#   money_transactions_this_month = Transaction.where(:transactiontype => 'top_up',created_at: start_time..Time.now )
#   if money_transactions_this_month.count > 0
#     (( money_transactions_this_month.collect(&:value).sum / cap ) * 100).ceil
#   else
#     '0'
#   end
#
# end

# def balance
#   user_id = id
#   balance = Transaction.where(:user_id => user_id).collect(&:value)
#   if balance.length > 0
#     balance.sum
#   else
#     "0.0"
#   end
#
# end
