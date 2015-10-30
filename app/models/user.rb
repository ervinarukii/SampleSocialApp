class User < ActiveRecord::Base
  acts_as_voter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :statuses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, as: :owner, dependent: :destroy


end
