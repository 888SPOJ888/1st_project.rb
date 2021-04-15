class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with name: "tweeter", password: "123456", :except => ["news"]
    protect_from_forgery with: :null_session 
    
    def news
      @tweets = Tweet.all
        @follow = Follow.all
        @users = User.all
        @tweet_api = []
        
        
        @tweets.each do |tweet|
          @tweets_likes = Like.where(:tweet_id  => tweet.id)
          @tweet_retweet = Tweet.where(:origin_tweet => tweet.id)
          @retweet_from = Tweet.where(:id => tweet.origin_tweet)
          
          @tweet_hash = {"id" => tweet.id}
          @tweet_hash.merge!("content"=> tweet.content)
          @tweet_hash.merge!("user_id"=> tweet.user_id)
          @tweet_hash.merge!("like_count"=> @tweets_likes.count)
          @tweet_hash.merge!("retweets_count"=> @tweet_retweet.count)
          if @retweet_from.first == nil
            @retweet_from = 0
            @tweet_hash.merge!("retwitted_from"=> @retweet_from)
          else
            @retweet_from.each do |rt|
              @retweet_user_list = rt.id
            end
            @tweet_hash.merge!("retwitted_from"=> @retweet_user_list)
            
          end
          
          @tweet_api << (@tweet_hash)
          
          
        end
        @final_api_tweet = @tweet_api.last(50)
        render :json => @final_api_tweet
        
    end
    
    def date_between
        fecha1 = Date.parse(params[:fecha1])    
        fecha2 = Date.parse(params[:fecha2])        
        
        @tweets = Tweet.where(created_at:fecha1..fecha2)
        render  json: @tweets 
        
    end

    respond_to do |format|
        format.html { render "api/new", :layout => false }
    end
    
    def create
        @tweet = Tweet.new(tweet_params)
        # @tweet.user = user
        if @tweet.save
          render json: @tweet
        else
          render json: { errors: "error", code: 500}
        end
      end
  
      private
      
    def api_params
      params.require(:api).permit(:fecha1, :fecha2)
    end
    
    
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end
    
    
    require 'json'
end
