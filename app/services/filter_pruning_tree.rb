class FilterPruningTree
  def initialize(array, ids)
    @array = array
    @ids = ids
  end

  def filter
    return false unless indicators_exists?

    @array.select do |themes|
      filter_sub_themes(themes)
      @ids.any? { |id| get_indicators(themes, 0).include? id.to_i } 
    end
  end

  private
    def filter_sub_themes(themes)
      themes["sub_themes"].keep_if do |categories|
        filter_categories(categories)
        @ids.any? { |id| get_indicators(categories, 1).include? id.to_i }  
      end
    end

    def filter_categories(categories)
      categories["categories"].keep_if do |indicators|
        filter_indicators(indicators)
        @ids.any? { |id| get_indicators(indicators, 2).include? id.to_i }  
      end
    end

    def filter_indicators(indicators)
      indicators["indicators"].keep_if do |indicator|
        @ids.try(:any?) { |id| indicator['id'] == id.to_i }
      end
    end

    def indicators_exists?
      (@ids.map(&:to_i) - all_indicator_ids).empty? 
    end

    def all_indicator_ids
      indicator_ids = []
      @array.each do |themes|
        indicator_ids << get_indicators(themes, 0)
      end
      indicator_ids.flatten
    end

    def get_indicators(hash, dimension)
      tree = ["sub_themes", "categories", "indicators", "id"].drop(dimension)
      
      hash.dig_and_collect(*tree)
    end
end