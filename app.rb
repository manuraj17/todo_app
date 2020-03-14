require 'sinatra'
require 'sinatra/json'

require_relative 'lib/todo_list'
require_relative 'lib/move_todo'
require_relative 'lib/todo'
require_relative 'lib/list'

List.new

get '/todos' do
end

post '/lists' do
  result = List.new(params[:name])
  if result
    json(
      "message" => "List created succesfully",
      result: {
        id: result.id, name: result.name, todos: result.todos
      })
  else
    json("message" => "Failed to create list")
  end
end

post '/todos' do
  todo = Todo.new(params[:description], params[:due_date], params[:reminder])
  list = List.find(params[:list_id])

  if list.add(todo.id)
    json(
      message: "Todo created succesfully",
      result: {
        id: todo.id,
        description: todo.description,
        list: {
          id: list.id,
          name: list.name
        }
      }
    )
  else
    todo.delete
    json(message: "Failed to create todo")
  end
end

put '/todos/:id' do
  todo = Todo.find(params['id'])
  if todo.update(params)
    json message: "Todo updated succesfully"
  else
    json(message: "Failed to update Todo")
  end
end

delete '/todos' do
  todo = Todo.find(params[:id])
  todo.delete

  json(message: "Todo removed succesfully")
end

post '/todos/:id/move' do
  MoveTodo.perform(params[:old_list_id], params[:new_list_id], params[:id])

  json(message: "Todo moved succesfully")
end

post '/todos/:id/add' do
  list = List.find(params['list_id'])
  todo = Todo.find(params['id'])

  if list.add(todo.id)
    json(message: "Todo added succesfully")
  else
    json(message: "Failed to move todo")
  end
end
