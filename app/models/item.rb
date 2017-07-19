class Item < ApplicationRecord
  validates :body, length: { minimum: 2, maxium: 500 }, presence: true
end
