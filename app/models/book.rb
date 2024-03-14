class Book < ApplicationRecord
  # include Elasticsearch::Model
  # include EsBook

  belongs_to :author
  belongs_to :category

  scope :not_1024,->{where category: 1}

end
