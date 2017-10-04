class Restaurant < ApplicationRecord
require 'yelp'
  has_many :reviews
  has_many :users, through: :reviews
end
