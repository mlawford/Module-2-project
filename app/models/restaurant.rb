class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  def self.create_5_restaurants
    @restaurants = []
    search('restaurant','New York City')["businesses"].sample(5).each do |restaurant|
      @restaurants << restaurant["name"]
      @restaurants << restaurant["url"]
    end
    #
    # @restaurant_urls = search('restaurant','New York City')["businesses"].sample(5).map do |restaurant|
    #     restaurant["url"]
    # end

      Restaurant.create({name:@restaurants[0],cuisine:"test",url:@restaurants[1]})
      Restaurant.create({name:@restaurants[2],cuisine:"test",url:@restaurants[3]})
      Restaurant.create({name:@restaurants[4],cuisine:"test",url:@restaurants[5]})
      Restaurant.create({name:@restaurants[6],cuisine:"test",url:@restaurants[7]})
      Restaurant.create({name:@restaurants[8],cuisine:"test",url:@restaurants[9]})
  end


end
