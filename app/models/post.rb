class Post < ApplicationRecord
  validates_presence_of :title
  has_rich_text :content
  has_many :comments,dependent: :destroy

  before_commit :set_created_by


  private
  def set_created_by
    if @current_user
      self.created_by = current_user.id
      self.updated_by = current_user.id
    end
  end
end
