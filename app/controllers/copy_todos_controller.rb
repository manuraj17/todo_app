class CopyTodosController < ApplicationController
  post '/api/todos/:id/copy' do
    status 201

    list = List.find(params['list_id'])
    todo = Todo.find(params['id'])

    if list.add(todo.id)
      json(message: "Todo added succesfully")
    else
      json(message: "Failed to move todo")
    end
  end
end
