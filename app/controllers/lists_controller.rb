# frozen_string_literal: true

class ListsController < ApplicationController
  get '/api/lists' do
    json(
      count: List.all.length,
      list: List.all
    )
  end

  post '/api/lists' do
    status 201

    result = List.new(params[:name])
    if result
      json(
        'message' => 'List created successfully',
        result: {
          id: result.id, name: result.name, todos: result.todos
        }
      )
    else
      json('message' => 'Failed to create list')
    end
  end

  get '/api/lists/:id' do
    list = List.find(params['id'])

    json(
      list: {
        id: list.id, name: list.name, todos: list.todos
      }
    )
  end
end
