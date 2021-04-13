class Tweet < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :likes
  has_many :retweet, :class_name => 'Tweet', :foreign_key => 'id'
  def add_like(user)
    Like.create(user: user, tweet: self)  
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy
  end

  def original_tweet
    Tweet.find(self.origin_tweet)
  end

  after_create do
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
    end
  end

  before_update do
    tweet.tags.clear
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
    end
  end
  
  scope :date_between, -> (start, finish) { where('created_at >= ? AND created_at <=?', start, finish) } 
  scope :tweets_for_me, ->(followers) { where user_id: followers }
end
