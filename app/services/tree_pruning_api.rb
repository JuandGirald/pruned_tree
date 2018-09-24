class TreePruningApi
  URL = 'https://kf6xwyykee.execute-api.us-east-1.amazonaws.com/production/tree'
  
  def initialize(params)
    @name = params[:name]
    @retries = 3 # or any numer
    @delay = 1 # number of seconds to wait between attemps
  end

  # handle prunning tree api request 
  # handle network/upstream problems
  # 
  def call
    begin
      response = tree_connection.get @name

      raise unless response.success? 
    rescue RuntimeError => err
      @retries -= 1
      sleep @delay

      retry
    ensure 
      return nil if @retries == 0
    end
    
    JSON.parse(response.body)
  end

  private
    def tree_connection
      Faraday.new(url: URL)
    end
end