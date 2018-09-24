require 'rails_helper'

RSpec.describe 'Tree Pruning Api', type: :request do
  let(:name) { 'input' }
  let(:existing_indicators) { { indicator_ids: ['31', '32', '1'] } }
  let(:not_existing_indicators) { { indicator_ids: ['1000'] } }

  describe 'GET /tree/:name' do
    context 'with correct name' do
      context 'with no indicator_ids params' do
        before { get "/tree/#{name}" }

        it 'returns the complete pruning tree' do
          expect(response).to have_http_status(200)
          expect(json.size).to eq(12) 
        end
      end

      context 'with indicator_ids params' do
        context 'when indicators exists' do
          before { get "/tree/#{name}", params: existing_indicators }
          
          it 'returns tree filtered with the specific indicators' do
            first_id = json[0]["sub_themes"][0]["categories"][0]["indicators"][0]["id"]
            
            expect(json.size).to eq(2)
            expect(existing_indicators[:indicator_ids]).to include(first_id.to_s)
          end
        end

        context 'when one of the indicators do not exist' do
          before { get "/tree/#{name}", params: not_existing_indicators }

          it 'returns a 404 eror' do
            expect(response).to have_http_status(404)
          end
        end
      end
    end
  end
end