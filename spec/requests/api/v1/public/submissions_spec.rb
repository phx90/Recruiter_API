require 'rails_helper'

RSpec.describe 'Submissions API', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let(:job_id) { job.id }
  let(:valid_attributes) { { name: 'Jane Doe', email: 'jane@example.com', mobile_phone: '1234567890', resume: 'Link to resume or resume content' }.to_json }
  let(:headers) { valid_headers }

  describe 'POST /api/v1/public/jobs/:job_id/submissions' do
    context 'when the request is valid' do
      before { post "/api/v1/public/jobs/#{job_id}/submissions", params: valid_attributes, headers: headers }

      it 'creates a submission' do
        expect(json['name']).to eq('Jane Doe')
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/api/v1/public/jobs/#{job_id}/submissions", params: { name: nil }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to include("can't be blank")
      end
    end
  end
end
