require 'rails_helper'

RSpec.describe TreePruningApi do
  let(:name) { 'input' }

  describe '#call' do
    context 'when connection succeed' do
      let(:response) { TreePruningApi.new(name: name).call }

      it 'returns an array with the pruned tree' do
        expect(response.is_a?(Array)).to be true
      end
    end

    # expect to catch one fail request
    context 'when connection not succeed' do
      let(:response) { TreePruningApi.new(name: name).call }

      it 'returns an array with the pruned tree', :retry => 100 do
        expect(response).to be_nil
      end
    end
  end
end