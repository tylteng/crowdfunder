class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  has_and_belongs_to_many :categories
  belongs_to :user # project owner


  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, numericality: {greater_than: 0}
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
        errors.add(:start_date, "can't be in the past")
    end
  end

  def end_date_cannot_be_before_start_date
    if end_date.present? && end_date < start_date
      errors.add(:end_date, "can't be before start date")
    end
  end

  def self.search(search)
    where("title || description LIKE ?", "%#{search}%")
  end

end
