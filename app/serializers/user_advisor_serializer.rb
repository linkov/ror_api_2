class UserAdvisorSerializer < ActiveModel::Serializer
  attributes :adviserIDs, :time_zone, :inspiring_rates_count, :isteam, :profileimage, :sharetoken, :showtutorials,
             :id, :lang, :imagethumb,  :activity_score, :advisor_score, :skills, :email, :advisorrate, :stripe_customer_id,
             :stripe_user_id, :admin, :uid, :balance, :referral_token, :website, :city, :showimage, :showcity, :showname,
             :showwebsite, :name, :image, :online

  has_many :user_skills
  has_many :advisordates
end

def inspiring_rates_count
  feedbacks = Feedback.where(:rating_id => ratings)
  Rateback.where(:feedback_id => feedbacks, :value => 5).count
end

def imagethumb
  if image
    return 'https://cdn.filestackcontent.com/output=format:pjpg/rotate=deg:"exif"/resize=height:160/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+image

  end
end

def adviserIDs
  myadvisers.collect(&:adviserid)
end

def skills
  projects.map { |p| p.artcategory.name }
end

def activity_score
  all_ratings_by_advisor = ratings.pluck("DISTINCT project_id").count

  {
    projects_reviewed: all_ratings_by_advisor,
    interested_students: 3,
    returning_students: 1,
    got_recommended: 1
  }
end

def advisor_score
  all_feedbacks_by_advisor = Feedback.where(:rating_id => ratings)

  discouraging_rates_by_advisor = Rateback.where(:feedback_id => all_feedbacks_by_advisor, :value => 1).count
  unhelpful_rates_by_advisor = Rateback.where(:feedback_id => all_feedbacks_by_advisor, :value => 2).count

  helpful_rates_by_advisor = Rateback.where(:feedback_id => all_feedbacks_by_advisor, :value => 3).count
  inspiring_rates_by_advisor = Rateback.where(:feedback_id => all_feedbacks_by_advisor, :value => 5).count

  {
    discouraging: discouraging_rates_by_advisor,
    unhelpful: unhelpful_rates_by_advisor,
    helpful: helpful_rates_by_advisor,
    inspiring: inspiring_rates_by_advisor
  }

end

def free_tier_complete

  cap = Setting.where(:name => 'charges_cap').first.value
  now = DateTime.current
  start_time = now.beginning_of_month
  money_transactions_this_month = Transaction.where(:transactiontype => 'top_up',created_at: start_time..Time.now )
  if money_transactions_this_month.count > 0
    (( money_transactions_this_month.collect(&:value).sum / cap ) * 100).ceil
  else
    '0'
  end

end

def balance
  user_id = id
  balance = Transaction.where(:user_id => user_id).collect(&:value)
  if balance.length > 0
    balance.sum
  else
    "0.0"
  end

end
