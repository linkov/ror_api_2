class Rateback < ApplicationRecord
  belongs_to :feedback

  scope :pr_counter, ->(advisor_id, current_user_id) { joins([feedback: {rating: :project}])
                                                         .where('ratebacks.value > 0')
                                                         .where('ratings.user_id' => advisor_id, 'projects.user_id' => current_user_id).count }
end
