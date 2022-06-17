class TagfeedbackSerializer < ActiveModel::Serializer
  attributes :id, :count, :projectfile_id, :arttag_id


def arttag_id
  object.arttag_id
end

def projectfile_id
  object.projectfile_id
end

end
