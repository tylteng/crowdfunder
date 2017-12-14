class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :rewards

  validates :dollar_amount, numericality: {greater_than_or_equal_to: 0}, presence: true
  validates :user, presence: true
  validates :project, presence: true
  validate  :owner_cannot_back_own_project

  def owner_cannot_back_own_project
    if user == project.user
      errors.add(:user, "can't be owner")
    end
  end

#returns an array of all the rewards you can get with this pledge
def pledge_rewards
  pledge_rewards = []
  @project=Project.find(project_id)
  @project.rewards.each do |reward|
    if dollar_amount >= reward.dollar_amount
      pledge_rewards << reward
    end
  end
  return pledge_rewards
end



end
