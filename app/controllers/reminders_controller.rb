# frozen_string_literal: true

class RemindersController < ApplicationController
  post '/api/todos/:id/reminders' do
    status 201

    todo = Todo.find(params['id'])
    reminder = Reminder.new(todo.id, params[:time_at])

    if reminder
      json(
        message: 'Reminder created successfully',
        result: {
          id: reminder.id,
          todo_description: todo.description,
          time_at: reminder.time_at
        }
      )
    else
      json(message: 'Failed to create todo')
    end
  end
end
