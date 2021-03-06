# frozen_string_literal: true

class Todo
  attr_accessor :id, :description, :due_date, :completed

  @@todos = []
  @@counter = 0

  def initialize(description, due_date = nil)
    @id = @@counter + 1
    @description = description
    @due_date = due_date

    @@todos << self
    @@counter += 1
  end

  def self.find(id)
    @@todos.find { |todo| todo.id == id.to_i }
  end

  def self.all
    @@todos
  end

  def delete
    @@todos.delete(self)
  end

  def update(params)
    @description = params['description'] unless params['description'].nil?
    @due_date = params['due_date'] unless params['due_date'].nil?
    true
  end
end
