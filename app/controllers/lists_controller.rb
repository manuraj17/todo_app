class ListsController < ApplicationController
  post '/api/lists' do
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
end
