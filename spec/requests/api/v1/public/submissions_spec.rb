require 'rails_helper'

RSpec.describe 'Submissions API', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let(:job_id) { job.id }
  let(:headers) { valid_headers }

  describe 'POST /api/v1/public/jobs/:job_id/submissions' do
    context 'when the request is valid' do
      let(:valid_attributes) { attributes_for(:submission, job_id: job_id) }

      before { post "/api/v1/public/jobs/#{job_id}/submissions", params: { submission: valid_attributes }.to_json, headers: headers }

      it 'creates a submission' do
        expect(json['name']).to eq(valid_attributes[:name])
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/api/v1/public/jobs/#{job_id}/submissions", params: { submission: attributes_for(:submission, job_id: job_id, name: nil) }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to include("can't be blank")
      end
    end
  end
end
