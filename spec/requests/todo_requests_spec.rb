# frozen_string_literal: true

RSpec.describe 'Todo requests', type: :request do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0

    Todo.class_variable_set :@@todos, []
    Todo.class_variable_set :@@counter, 0

    List.new('default')
  end

  it 'create todo request' do
    params = { description: 'Finish assignment', list_id: 1 }

    post '/api/todos', params

    expect(last_response).to be_created
    body = JSON.parse(last_response.body)

    expect(body['message']).to eq('Todo created successfully')
    expect(body['result']['id']).not_to be_nil
    expect(body['result']['description']).to eq('Finish assignment')
    expect(body['result']['list']['id']).to eq(1)
    expect(body['result']['list']['name']).to eq('default')
  end

  it 'updates a todo' do
    params = { description: 'Finish assignment', list_id: 1 }

    post '/api/todos', params

    expect(last_response).to be_created
    body = JSON.parse(last_response.body)

    expect(body['result']['id']).not_to be_nil

    params = { description: 'Finish problem 1' }
    id = body['result']['id']
    put "/api/todos/#{id}", params

    body = JSON.parse(last_response.body)

    expect(body['message']).to eq('Todo updated successfully')
  end

  it 'deletes a todo' do
    todo = Todo.new('test_todo')
    list = List.find(1)
    list.add(todo.id)
    params = { id: todo.id }

    delete '/api/todos', params
    expect(last_response).to be_ok

    result = Todo.find(todo.id)
    expect(result).to be_nil
  end

  it 'adds existing todo to a new list' do
    todo = Todo.new('existing_todo')
    list = List.find(1)
    list.add(todo.id)

    new_list = List.new('second list')

    post "/api/todos/#{todo.id}/copy", { list_id: new_list.id }
    expect(last_response).to be_created

    expect(new_list.todos).to match_array([todo.id])
  end

  it 'moves todo to a new list' do
    todo = Todo.new('existing_todo')
    list = List.find(1)
    list.add(todo.id)

    new_list = List.new('second list')
    params = { old_list_id: list.id, new_list_id: new_list.id }

    post "/api/todos/#{todo.id}/move", params
    expect(last_response).to be_created

    expect(list.todos).not_to include(todo.id)
  end

  it 'retrieves all lists' do
    List.new('work')
    List.new('health')

    get '/api/lists'

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)

    lists = body['list'].map { |list| list['name'] }

    expect(lists).to match_array(%w[default work health])
  end

  it 'retrieves a todo' do
    todo = Todo.new('todo 1')

    get "/api/todos/#{todo.id}"

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)

    expect(body['description']).to eq('todo 1')
  end
end
