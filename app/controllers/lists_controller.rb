# frozen_string_literal: true

class ListsController < ApplicationController
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
end
