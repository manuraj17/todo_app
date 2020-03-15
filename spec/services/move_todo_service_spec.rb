# frozen_string_literal: true

require 'date'
require 'spec_helper'

RSpec.describe 'Moving todos across lists' do
  context 'Move frome one list to next' do
    it 'todo is present only in one list' do
      list_1 = List.new('list_1')
      list_2 = List.new('list_2')

      list_1.add(1)
      list_1.add(2)
      list_2.add(3)
      list_2.add(4)

      expect(list_1.todos).to match_array([1, 2])
      expect(list_2.todos).to match_array([3, 4])

      MoveTodoService.perform(list_2.id, list_1.id, 3)

      expect(list_1.todos).to match_array([1, 2, 3])
      expect(list_2.todos).to match_array([4])
    end
  end
end
