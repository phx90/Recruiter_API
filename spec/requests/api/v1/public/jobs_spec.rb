require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:jobs) { create_list(:job, 10, recruiter: recruiter) }
  let(:job_id) { jobs.first.id }
  let(:headers) { valid_headers }

  describe 'GET /api/v1/public/jobs' do
    before { get '/api/v1/public/jobs', headers: headers }

    it 'returns jobs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/public/jobs/:id' do
    before { get "/api/v1/public/jobs/#{job_id}", headers: headers }

    it 'returns the job' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(job_id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
