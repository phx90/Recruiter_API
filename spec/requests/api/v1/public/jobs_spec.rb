require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:jobs) { create_list(:job, 30, recruiter: recruiter, status: 'active') }
  let(:job_id) { jobs.first.id }
  let(:headers) { valid_headers.merge({ 'Accept': 'application/json' }) }

  def json
    JSON.parse(response.body)
  end

  describe 'GET /api/v1/public/jobs' do
    before { get '/api/v1/public/jobs', headers: headers, params: { page: 1, per_page: 10 } }

    it 'returns jobs' do
      expect(json['jobs']).not_to be_empty
      expect(json['jobs'].size).to eq(10)
    end

    it 'returns pagination meta data' do
      expect(json['meta']).not_to be_empty
      expect(json['meta']['current_page']).to eq(1)
      expect(json['meta']['total_pages']).to eq(3)
      expect(json['meta']['total_count']).to eq(30)
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

