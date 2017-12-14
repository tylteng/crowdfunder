class Reward < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :users

  # validates :description, presence: true
  # validates :dollar_amount, presence: true
end
