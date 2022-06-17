class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transactiontype, :value, :created_at, :display_name, :display_value
  has_one :user


  def display_name
    if object.transactiontype == 'signup_bonus'
      'Your signup bonus'
    elsif object.transactiontype == 'upload'
      'Project upload'
    elsif object.transactiontype == 'top_up'
      'Funds added'
    elsif object.transactiontype == 'inspiring_feedback'
      'You gave inspiring feedback'
    elsif object.transactiontype == 'referral_bonus'
      'One of your friends joined'
    else
      'Unknown transaction'
    end

  end

  def display_value
    if object.value < 0
      '- $' + object.value.abs.to_s
    else
      '+ $' + object.value.abs.to_s
    end
  end

end
