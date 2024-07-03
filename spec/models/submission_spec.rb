require 'rails_helper'
RSpec.describe Submission, type: :model do
  it "creates a submission with valid attributes" do
    submission = create(:submission)
    expect(submission).to be_valid
    expect(submission.name).to be_present
    expect(submission.email).to be_present
    expect(submission.mobile_phone).to be_present
    expect(submission.resume).to be_present
  end
end

RSpec.describe Submission, type: :model do
  it { should belong_to(:job) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:mobile_phone) }
  it { should validate_presence_of(:resume) }
  it { should validate_presence_of(:job_id) }

  context 'uniqueness validation' do
    subject { create(:submission) }
    it { should validate_uniqueness_of(:email).scoped_to(:job_id).with_message('You have already applied for this job') }
  end
end

