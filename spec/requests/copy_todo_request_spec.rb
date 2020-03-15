# frozen_string_literal: true

RSpec.describe 'Copy todos', type: :request do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0

    Todo.class_variable_set :@@todos, []
    Todo.class_variable_set :@@counter, 0

    List.new('default')
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
end
