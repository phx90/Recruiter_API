class Job < ApplicationRecord
  belongs_to :recruiter
  has_many :submissions, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :recruiter_id, presence: true
end
