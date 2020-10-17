class BlogPost < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { minimum: 10 }
  validates :content, presence: true

end
