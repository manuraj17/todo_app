RSpec.describe ListsSerializerService do
  describe 'serializers a collection of todos' do
    before(:each) do
      List.class_variable_set :@@lists, []
      List.class_variable_set :@@counter, 0

      Todo.class_variable_set :@@todos, []
      Todo.class_variable_set :@@counter, 0

      List.new('default')
    end

    it 'returns a hash in expected format' do
      List.new("personal")
      List.new("office")

      result = described_class.perform(List.all)

      expect(result.count).to eq(3)
      expect(result[0][:id]).not_to be_nil
      expect(result[0][:name]).to eq('default')
      expect(result[1][:id]).not_to be_nil
      expect(result[1][:name]).to eq('personal')
      expect(result[2][:id]).not_to be_nil
      expect(result[2][:name]).to eq('office')
    end
  end
end
