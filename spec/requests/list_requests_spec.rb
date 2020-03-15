# frozen_string_literal: true

RSpec.describe 'List requests', type: :request do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0
  end

  it 'retrieves all lists' do
    List.new('work')
    List.new('health')

    get '/api/lists'

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)

    lists = body['list'].map { |list| list['name'] }

    expect(lists).to match_array(%w[work health])
  end

  it 'creates a list' do
    params = { name: 'personal' }

    post '/api/lists', params

    expect(last_response).to be_created
    body = JSON.parse(last_response.body)

    expect(body['message']).to eq('List created successfully')
    expect(body['result']['id']).not_to be_nil
    expect(body['result']['name']).to eq('personal')
  end

  it 'gets a list' do
    List.new('default')

    get '/api/lists/1'

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)

    expect(body['list']['id']).not_to be_nil
    expect(body['list']['name']).to eq('default')
  end
end
