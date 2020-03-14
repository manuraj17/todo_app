class Todo
  attr_accessor :id, :description, :due_date, :completed, :reminder

  @@todos = []
  @@counter = 0

  def initialize(description, due_date = nil, reminder = nil)
    @id = @@counter + 1
    @description = description
    @due_date = due_date
    @reminder = reminder

    @@todos << self
    @@counter += 1
  end

  def self.find(id)
    @@todos.find { |todo| todo.id == id.to_i }
  end

  def delete
    @@todos.delete(self)
  end

  def self.show
    @@todos.each do |todo|
      puts todo.id, todo.description
    end
  end

  def update(params)
    @description = params["description"] if params["description"] != nil
    @due_date = params["due_date"] if params["due_date"] != nil
    @reminder = params["reminder"] if params["reminder"] != nil
    true
  end
end
