# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_and_belongs_to_many :cards
  has_many :reviewqueues, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :skips, dependent: :destroy
  has_many :myadvisers, dependent: :destroy
  has_many :newsfeedfollows, dependent: :destroy
  has_many :projectresorts, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :advisordates, dependent: :destroy
  has_many :unconnected_payments, dependent: :destroy

  after_update :track_online

  def clean_stripe!
    update!(stripe_user_id: nil, stripe_customer_id: nil)
    unconnected_payments.delete_all
  end

  def status_for_advisor(advisor_id)
    status = 'First time advisor'

    n_ratings_for_advisor = Rating.joins(:project)
                                  .where('projects.user_id' => id, 'ratings.user_id' => advisor_id)
                                  .pluck("DISTINCT project_id").count

    if Rateback.pr_counter(advisor_id, id).zero?
      return status
    end

    if n_ratings_for_advisor < 5
      status = 'Interesting advisors'
    end

    if n_ratings_for_advisor >= 5
      status = 'Regular advisor'
    end

    status
  end

  private

  def track_online
    if online_before_last_save != online
      AppearanceChannel.broadcast_to({user_id: id, online: online}, 'appearance_channel')
    end
  end
end
