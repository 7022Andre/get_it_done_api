class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :lists, dependent: :delete_all
end
