require 'rails_helper'
RSpec.describe Recruiter, type: :model do
  it "creates a recruiter with valid attributes" do
    recruiter = create(:recruiter)
    expect(recruiter).to be_valid
    expect(recruiter.name).to be_present
    expect(recruiter.email).to be_present
    expect(recruiter.password).to be_present
  end
end

RSpec.describe Recruiter, type: :model do
  it { should have_many(:jobs).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end

