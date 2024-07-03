class Job < ApplicationRecord
  belongs_to :recruiter
  has_many :submissions, dependent: :destroy

  validates :title, :description, :recruiter_id, presence: true

  scope :active_or_open, -> { where(status: ['active', 'open']) }
  scope :search, ->(query) { ransack(title_or_description_or_skills_cont: query).result }
end
