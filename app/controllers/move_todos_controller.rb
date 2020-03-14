class MoveTodosController < ApplicationController
  post '/api/todos/:id/move' do
    status 201

    MoveTodoService.perform(
      params[:old_list_id],
      params[:new_list_id],
      params[:id]
    )

    json(message: "Todo moved succesfully")
  end
end
