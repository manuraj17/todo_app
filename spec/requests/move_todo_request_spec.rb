# frozen_string_literal: true

RSpec.describe 'Move todos', type: :request do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0

    Todo.class_variable_set :@@todos, []
    Todo.class_variable_set :@@counter, 0

    List.new('default')
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
end
