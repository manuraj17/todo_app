# frozen_string_literal: true

RSpec.describe 'Add Reminder', type: :request do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0

    Todo.class_variable_set :@@todos, []
    Todo.class_variable_set :@@counter, 0

    List.new('default')
  end

  it 'adds a new reminder for the todo' do
    todo = Todo.new('existing_todo')
    list = List.find(1)
    list.add(todo.id)
    time = (DateTime.now + 2).to_s

    params = { todo_id: todo.id, time_at: time }

    post "/api/todos/#{todo.id}/reminders", params
    expect(last_response).to be_created
    body = JSON.parse(last_response.body)

    expect(body['message']).to eq('Reminder created successfully')
    expect(body['result']['id']).not_to be_nil
    expect(body['result']['todo_description']).to eq(todo.description)
    expect(body['result']['time_at']).to eq(time)
  end
end
