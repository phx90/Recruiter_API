class Recruiter < ApplicationRecord
  has_secure_password  
  searchkick
  has_many :jobs, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  def generate_jwt
    JWT.encode({ recruiter_id: id, exp: 1.week.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

end
