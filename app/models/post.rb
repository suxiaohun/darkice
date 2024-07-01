class Post < ApplicationRecord
  validates_presence_of :title
  has_rich_text :content
  has_many :comments,dependent: :destroy

  def set_created_by(user)
      self.created_by = user.id
      self.created_by_name = user.name
      self.updated_by = user.id
      self.updated_by_name = user.name
  end
end
