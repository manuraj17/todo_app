class List
  DEFAULT = "default".freeze

  attr_accessor :id, :name, :todos, :add

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

  def add(todo_id)
    @todos << todo_id
  end

  def delete(todo_id)
    @todos.reject! { |value| value == todo_id.to_i }
  end

  def self.show
    @@lists.each do |list|
      puts list.id, list.name
    end
  end
end
