module Api
	module V1
		class TreePruningController < ApiController
      def tree
        response = TreePruningApi.new(name: params[:name]).call
        
        if response
          response = FilterPruningTree.new(response, params[:indicator_ids]).filter if params[:indicator_ids].present?
          
          if response
            render json: response
          else
            render json: { error: 'one indicators was not found' }, status: 404
          end
        else
          render json: { error: 'All retries are exhausted' }, status: 500 
        end
			end
		end
	end
end
