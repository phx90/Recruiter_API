class Job < ApplicationRecord
  searchkick
  belongs_to :recruiter
  has_many :submissions, dependent: :destroy

  validates :title, :description, :recruiter_id, presence: true

  scope :active_or_open, -> { where(status: ['active', 'open']) }
end
