class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validates :project, presence: true
  validate  :owner_cannot_back_own_project

  def owner_cannot_back_own_project
    if user == project.user
      errors.add(:user, "can't be owner")
    end
  end


end
