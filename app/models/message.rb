class Message < ActiveRecord::Base
  has_many :recipients, :through => :messagings
  has_many :messagings

  belongs_to :parent, class_name: "Message", foreign_key: 'parent_id'

  def sender
    return User.find_by_id(self.sender_id)
  end

  def children
    return Message.where(parent_id: self.id)
  end

  def not_user_children(user)
    return Message.where('sender_id != ? AND parent_id = ?', user.id, self.id)
  end

  def has_child
    @children = Message.where(parent_id: self.id)
    if !@children.blank?
      return true
    else
      return false
    end
  end
end
