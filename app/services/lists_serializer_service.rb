# frozen_string_literal: true

class ListsSerializerService
  def self.perform(lists)
    lists.map do |list|
      { id: list.id, name: list.name, todos: list.todos }
    end
  end
end
