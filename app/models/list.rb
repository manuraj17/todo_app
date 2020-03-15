# frozen_string_literal: true

# rubocop:disable Lint/DuplicateMethods
class List
  DEFAULT = 'default'

  attr_accessor :id, :name, :todos, :add, :all

  @@lists = []
  @@counter = 0

  def initialize(name = DEFAULT)
    @name = name
    @todos = []
    @id = @@counter + 1

    @@lists << self
    @@counter += 1
  end

  def self.find(id)
    @@lists.detect { |list| list.id == id.to_i }
  end

  def self.all
    @@lists.map do |list|
      { id: list.id, name: list.name, todos: list.todos }
    end
  end

  def add(todo_id)
    @todos << todo_id
  end

  def delete(todo_id)
    @todos.reject! { |value| value == todo_id.to_i }
  end
end
# rubocop:enable Lint/DuplicateMethods
