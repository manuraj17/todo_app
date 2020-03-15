# frozen_string_literal: true

require 'date'

RSpec.describe 'Testing Reminder' do
  before(:each) do
    Reminder.class_variable_set :@@reminders, []
    Reminder.class_variable_set :@@counter, 0
  end

  context 'creating a reminder' do
    it 'creates a default list' do
      time = (DateTime.now + 1).iso8601
      reminder = Reminder.new(1, time)

      expect(reminder.id).to eq(1)
      expect(reminder.todo_id).to eq(1)
      expect(reminder.time_at).to eq(time)
    end

    it 'increments the counter' do
      time_1 = (DateTime.now + 1).iso8601
      time_2 = (DateTime.now + 2).iso8601
      reminder_1 = Reminder.new(1, time_1)
      reminder_2 = Reminder.new(1, time_2)

      expect(reminder_1.id).to eq(1)
      expect(reminder_2.id).to eq(2)
    end
  end

  context 'performing actions on created list' do
    it 'retrieves all reminders' do
      time_1 = (DateTime.now + 1).iso8601
      time_2 = (DateTime.now + 2).iso8601
      reminder_1 = Reminder.new(1, time_1)
      reminder_2 = Reminder.new(1, time_2)

      all = Reminder.all
      ids = all.map(&:id)
      times = all.map(&:time_at)
      expect(ids).to match_array([reminder_1.id, reminder_2.id])
      expect(times).to match_array([time_1, time_2])
    end
  end
end
