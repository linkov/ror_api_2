class ProjectadvisorSerializer < ActiveModel::Serializer
  attributes :id, :invitesent, :project_id, :myadviser_id, :adviser_user_id

  def adviser_user_id
    adviser = Myadviser.find(object.myadviser_id)
    user = User.find(adviser.adviserid)
    return user.id
  end

end
