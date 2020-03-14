class MoveTodoService
  def self.perform(old_list_id, new_list_id, todo_id)
    old_list = List.find(old_list_id)
    new_list = List.find(new_list_id)

    old_list.delete(todo_id)
    new_list.add(todo_id)
  end
end
