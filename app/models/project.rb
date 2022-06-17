class Project < ApplicationRecord
  belongs_to :user
  belongs_to :artcategory
  has_one :parentcategory

  has_many :projectadvisors, dependent: :destroy
  has_many :avratingparams, dependent: :destroy
  has_many :projectresorts, dependent: :destroy
  has_many :projectfiles, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :reviewqueues, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :skips, dependent: :destroy
  has_many :project_skills, dependent: :destroy
  has_many :presenterquestions, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :projectquestionanswers, dependent: :destroy
  has_many :unconnected_payments, dependent: :destroy

  accepts_nested_attributes_for :presenterquestions, allow_destroy: true, reject_if: :all_blank

  accepts_nested_attributes_for :projectfiles
  accepts_nested_attributes_for :avratingparams
  accepts_nested_attributes_for :invites
  accepts_nested_attributes_for :projectadvisors
end
