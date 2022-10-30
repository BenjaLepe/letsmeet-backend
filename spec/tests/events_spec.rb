require 'rails_helper'

describe 'get all events route', type: :request do
  let!(:events) { FactoryBot.create_list(:random_events, 5) }
  before { get '/events/' }
  it 'returns all questions' do
    expect(JSON.parse(response.body).size).to eq(5)
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
