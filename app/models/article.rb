class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  # BUG: This validation is too strict - business wants minimum 10 characters  
  validates :body, presence: true, length: { minimum: 100 }
end
