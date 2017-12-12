class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    return self.first_name + " " + self.last_name
  end


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

  def projects_supported
    @pledges = Pledge.all
    project_list = []
    @pledges.each do |pledge|
        if pledge.user_id == self.id
          project_list << pledge.project_id
        end
    end
    project_list = project_list.uniq.sort
    return project_list
  end
end
