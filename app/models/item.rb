class Item < ApplicationRecord
  belongs_to :list
  
  validates :body, length: { minimum: 2, maxium: 500 }, presence: true
end
