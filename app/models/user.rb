class User < ApplicationRecord
  has_many :tweets
  has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         validates :name, presence: true
         validates :avatar_url, presence: true
       
         has_many :tweets, dependent: :destroy
         has_many :likes, dependent: :destroy
       
         has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
         has_many :followers, through: :received_follows, source: :follower
       
         has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
         has_many :followings, through: :given_follows, source: :followed_user     
         
  def to_s
    name
  end

  def followed?(user)
    !self.followings.find{|followed| followed.id == user.id}
  end

  def retweet_count
    acc = 0
    self.tweets.each do |tweet|
      acc += 1 if !tweet.origin_tweet.nil? 
    end
    acc
  end


end
