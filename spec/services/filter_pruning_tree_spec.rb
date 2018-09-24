require 'rails_helper'

RSpec.describe FilterPruningTree do
  let(:array) { TreePruningApi.new(name: 'input').call}
  let(:existing_ids) { ['31', '32', '1'] }
  let(:non_existing_ids) { ['1000', '40'] }
  
  describe '#filter' do
    context 'when tree contains filtered indicators' do
      let(:tree) { FilterPruningTree.new(array, existing_ids) }
      
      it 'returns filtered indicators tree' do
        expect(tree.filter.size).to eq(2)
        expect(tree.send(:all_indicator_ids).size).to eq(existing_ids.size)
      end
    end

    context 'when tree not contains filtered indicators' do
      let(:tree) { FilterPruningTree.new(array, non_existing_ids) }
      
      it 'returns false' do
        expect(tree.filter).to be false
      end
    end
  end
end