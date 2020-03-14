require 'date'
require 'spec_helper'

require_relative '../../lib/list'

RSpec.describe 'Testing List' do
  before(:each) do
    List.class_variable_set :@@lists, []
    List.class_variable_set :@@counter, 0
  end

  context 'creating a list' do
    it 'creates a default list' do
      list = List.new()

      expect(list.id).to eq(1)
      expect(list.name).to eq("default")
    end

    it 'increments the counter' do
      list_1 = List.new('test_1')
      list_2 = List.new('test_2')

      expect(list_1.id).to eq(1)
      expect(list_2.id).to eq(2)
    end
  end

  context 'performing actions on created list' do
    it 'adds a todo to a list' do
      List.new
      list_1 = List.new('list_1')
      list_1.add(1)

      result = List.find(list_1.id)

      expect(result.todos).to match_array([1])
      expect(list_1.todos).to match_array([1])
    end

    it 'deletes a todo from list' do
      List.new
      list_1 = List.new('list_1')
      list_1.add(1)

      expect(list_1.todos).to match_array([1])

      list_1.delete(1)

      expect(list_1.todos).to match_array([])

      result = List.find(list_1.id)

      expect(result.todos).to match_array([])
    end
  end
end
