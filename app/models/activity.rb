class Activity < ActiveRecord::Base
  # acts_as_commentable
  # acts_as_votable
  
  belongs_to :user, foreign_key: :owner_id
  belongs_to :trackable, polymorphic: true

  validates :trackable, :owner, presence: true

  def status?
    self.trackable_type.eql? "Status"
  end

end
