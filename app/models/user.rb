class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :lists
end
