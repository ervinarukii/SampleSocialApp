class Status < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable

  include PublicActivity::Model
  tracked owner: :user
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
