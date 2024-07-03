require 'rails_helper'
RSpec.describe Job, type: :model do
  it "creates a job with valid attributes" do
    job = create(:job)
    expect(job).to be_valid
    expect(job.title).to be_present
    expect(job.description).to be_present
    expect(job.start_date).to be_present
    expect(job.end_date).to be_present
    expect(job.status).to eq("active")
    expect(job.skills).to be_present
  end
end

RSpec.describe Job, type: :model do
  it { should belong_to(:recruiter) }
  it { should have_many(:submissions).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:recruiter_id) }
end

