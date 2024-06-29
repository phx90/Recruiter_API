require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  it { should have_many(:jobs).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
