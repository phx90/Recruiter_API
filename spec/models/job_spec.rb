require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should belong_to(:recruiter) }
  it { should have_many(:submissions).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:recruiter_id) }
end
