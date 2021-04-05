class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweet, :class_name => 'Tweet', :foreign_key => 'id'
  validates :content, presence: true

def add_like(user)
  Like.create(user: user, tweet: self)  
end

def remove_like(user)
  Like.where(user: user, tweet: self).first.destroy
end

def original_tweet
  Tweet.find(self.origin_tweet)
  
end

scope :tweets_for_me, ->(followings) { where user_id: followings }
end
