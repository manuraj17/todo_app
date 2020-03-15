# frozen_string_literal: true

require 'date'

RSpec.describe 'Testing Todos' do
  before(:each) do
    Todo.class_variable_set :@@todos, []
    Todo.class_variable_set :@@counter, 0
  end

  context 'creating a todo' do
    it 'stores the created todo' do
      todo = Todo.new('Todo Test 1', nil, nil)

      expect(todo.id).not_to be_nil
      expect(todo.description).to eq('Todo Test 1')
      expect(todo.due_date).to be_nil

      result = Todo.find(todo.id)
      expect(result).to eq(todo)
    end

    it 'increments the counter' do
      todo_1 = Todo.new('test_1')
      todo_2 = Todo.new('test_2')

      expect(todo_1.id).to eq(1)
      expect(todo_2.id).to eq(2)
    end
  end

  context 'performing actions on created todo' do
    it 'deletes an existing todo' do
      todo_1 = Todo.new('test_1')
      Todo.new('test_2')

      id = todo_1.id
      todo_1.delete

      result = Todo.find(id)
      expect(result).to be_nil
    end

    it 'udpates an existing todo' do
      todo = Todo.new('test_1', Date.today + 2, Date.today)

      expect(todo.description).to eq('test_1')

      todo.update({ 'description' => 'Updated text' })

      result = Todo.find(todo.id)
      expect(result.description).to eq('Updated text')
      expect(result.due_date).to eq(Date.today + 2)
    end
  end
end
