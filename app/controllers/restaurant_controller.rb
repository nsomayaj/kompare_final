
# retauarant controller takes user input from restaurant index page and outputs
# results from kmeans algorithm
# kmeans algorithm from https://github.com/id774/kmeans

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'

class RestaurantController < ApplicationController
  def index

    @my_rest = params[:my_rest]
    @my_city = params[:my_city]
    @target_city = params[:target_city]

    if @my_city.nil?
      @my_city = "Boston"
    else
      @my_city = params[:my_city]
    end

    if @my_rest.nil? || @my_rest.to_i > Restaurant.count || @my_rest.to_i < 0
      @my_rest = 1280 # sets default to assiago (a restaurant)
    else
      @my_rest = params[:my_rest]
    end

    if @target_city.nil?
      @target_city = "Chicago"
    else
      @target_city = params[:target_city]
    end

    # initialize var with user's rest data
    #identify user cuisine to narrow items taken from database
    r = Restaurant.find_by(id: @my_rest)
    @user_cuisine = r.cuisine

    # create a hash from database for kmeans
    @hash = {}
    # add user's restaurant to hash
    r_rating = r.rating*10
    r_rating = r_rating.to_i
    @hash.merge!(Hash[r.name, Hash["cost", r.cost.to_i, "rating", r_rating, "votes", r.votes.to_i]])

    # take subset from database and add to hash
    restaurants = Restaurant.where(city: @target_city)
    restaurants = restaurants.where("cuisine LIKE ?", "%#{@user_cuisine}%").all
    restaurants.each do |rest|
      # convert float to int for kmeans module
      rest_rating = rest.rating*10
      rest_rating = rest_rating.to_i
      # merge hashes
      @hash.merge!(Hash[rest.name, Hash["cost", rest.cost.to_i, "rating", rest_rating, "votes", rest.votes.to_i]])
    end


    # pass @hash to module
    @kmeans = Kmeans::Cluster.new(@hash, {
      :centroids => 3,
      :loop_max => 100 })

    # make kmeans cluster
    @kmeans.make_cluster

    # find cluster with user's restaurant
    target_str = r.name
    @target_str_id = 0
    kmeans_count = 0
    while kmeans_count < @kmeans.cluster.values.count
      test_hash = @kmeans.cluster.values[kmeans_count]
      test_hash_count = 0
      while test_hash_count < test_hash.count
        if test_hash[test_hash_count].to_s == target_str
          @target_str_id = kmeans_count
          break
        end
        test_hash_count+= 1
      end
      kmeans_count+= 1
    end

    # create hash of url of stuff in kmeans cluster
    @url_hash = {}
    @kmeans.cluster.values[@target_str_id].each do |rest|
      r = Restaurant.find_by name: rest
      url = r.url
      @url_hash.merge!(Hash[rest,url])
    end

    # create hash of cuisines of stuff in kmeans cluster
    @cuisine_hash = {}
    @kmeans.cluster.values[@target_str_id].each do |rest|
      r = Restaurant.find_by name: rest
      cuisine = r.cuisine
      @cuisine_hash.merge!(Hash[rest,cuisine])
    end

    render("index.html.erb")
  end

  def show
    @restaurants = Restaurant.all
  end

end
