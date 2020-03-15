# frozen_string_literal: true

class TodosController < ApplicationController
  post '/api/todos' do
    status 201

    todo = Todo.new(params[:description], params[:due_date])
    list = List.find(params[:list_id])

    if list.add(todo.id)
      json(
        message: 'Todo created successfully',
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
      json(message: 'Failed to create todo')
    end
  end

  get '/api/todos/:id' do
    todo = Todo.find(params['id'])

    json(
      id: todo.id,
      description: todo.description,
      due_date: todo.due_date
    )
  end

  put '/api/todos/:id' do
    todo = Todo.find(params['id'])
    if todo.update(params)
      json message: 'Todo updated successfully'
    else
      json(message: 'Failed to update Todo')
    end
  end

  delete '/api/todos' do
    todo = Todo.find(params[:id])
    todo.delete

    json(message: 'Todo removed successfully')
  end
end
