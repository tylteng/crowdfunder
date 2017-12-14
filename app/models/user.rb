class User < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :rewards
  has_many :pledges

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    return self.first_name + " " + self.last_name
  end

# returns the total amount a given user has pledged
  def pledge_total
    @pledges = Pledge.all
    pledge_total = 0
    @pledges.each do |pledge|
      if pledge.user_id == self.id
        pledge_total = pledge_total + pledge.dollar_amount
      end
    end
    return pledge_total
  end


#returns a hash with project_id as key and total pledge amount as value
  def projects_supported
    @pledges = Pledge.all
    project_list = {}
    @pledges.each do |pledge|
        if pledge.user_id == self.id
          if project_list.has_key?(pledge.project_id)
            project_list[pledge.project_id] += pledge.dollar_amount
          else
          project_list[pledge.project_id] = pledge.dollar_amount
          end
        end
    end
    return project_list
  end

  #returns an array of all the rewards this user can get
  def user_pledge_rewards
    user_pledge_rewards = []
    self.project_pledge_remaining.each do |project_id, pledge_amount_remaining|
      project = Project.find(project_id)
      reward_list = project.rewards
      reward_list.each do |reward|
        if pledge_amount_remaining >= reward.dollar_amount
          user_pledge_rewards << reward
        end
      end
    end
    return user_pledge_rewards
  end

# returns a hash with reward selected description as the key and the number selected as value
def rewards_selected
  rewards_selected = Hash.new(0)
  self.rewards.each do |reward|
    rewards_selected[reward.description]+= 1
  end
  return rewards_selected
end


#returns a hash with project_id as key and total selected reward value as value
def claimed_rewards_by_project
  claimed_rewards_by_project = Hash.new(0)
  self.rewards_selected.each do |reward, frequency|
    selected_reward = Reward.find_by(description: reward)
    claimed_rewards_by_project[selected_reward.project_id] += selected_reward.dollar_amount
  end
  return claimed_rewards_by_project
end

#returns a hash with project id as key and pledge balance remaining as value
def project_pledge_remaining
  project_pledge_remaining = Hash.new(0)
  self.projects_supported.each do |project_id, total_pledge_amount|
    project_pledge_remaining[project_id] = total_pledge_amount
  end
  self.claimed_rewards_by_project.each do |project_id, total_reward_amount|
    project_pledge_remaining[project_id] -= total_reward_amount
  end
  return project_pledge_remaining
end

end
