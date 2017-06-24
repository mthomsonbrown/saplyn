# User model
class User < ActiveRecord::Base
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create -> { self.auth_token = SecureRandom.hex }

  def all_posts
    posts.all
  end

  def new_post
    @post = posts.new
  end

  def new_post_with_params(parameters)
    @post = posts.new parameters
  end
end
