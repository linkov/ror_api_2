class ProjectSerializer < ActiveModel::Serializer
  attributes :isprivate, :private, :id, :title, :description, :inspiringrate, :sharetoken, :purpose, :projectfiles_attributes,
             :choosethebest, :presenterquestion, :category_name, :artcategory_id, :insightscategory, :invites, :show_payment_promise_to_anon

  has_many :projectfiles, serializer: ProjectfileSerializer
  has_many :projectquestionanswers
  has_many :avratingparams
  belongs_to :user
  has_many :projectadvisors
  has_many :project_skills
  has_many :presenterquestions



  def projectfiles
    object.projectfiles.order(:order)
  end

  def isprivate
    object.private
  end


  def projectfiles_attributes
    object.projectfiles
  end

  def invites
    object.invites.select(:id, :email, :name, :message, :sent)
  end

  def category_name
    Artcategory.find(object.artcategory_id).name unless object.artcategory_id.nil?
  end


end
