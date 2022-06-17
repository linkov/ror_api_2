class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user, :body, :read, :created_at, :paymentrequestamount, :paymentrequestapproved,
             :paymentrequesttime, :paymentrequestdenied, :special

  def user
    User.find(object.user_id)
  end
end
