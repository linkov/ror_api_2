class StorySerializer < ActiveModel::Serializer
  attributes :id, :flow, :active, :name, :finished
  has_many :cards

  def finished
    finished_cards = object.cards.where(:id => current_user.cards.collect(&:id))
    finished_cards.count == object.cards.count
  end
end
