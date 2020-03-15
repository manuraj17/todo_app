# frozen_string_literal: true

class Reminder
  attr_accessor :id, :todo_id, :time_at

  @@reminders = []
  @@counter = 0

  def initialize(todo_id, time_at)
    @id = @@counter + 1
    @todo_id = todo_id
    @time_at = time_at

    @@reminders << self
    @@counter += 1
  end

  def self.all
    @@reminders
  end
end
