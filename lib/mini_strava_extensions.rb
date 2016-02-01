module MiniStrava
  class Client
    def search_segments bounds
      response = get '/segments/search', bounds: bounds.join(',')
      parse_search_segments_response response, Models::Segment
    end

    def parse_search_segments_response response, type
      attributes = JSON.parse response.body
      attributes = attributes['segments']
      if attributes.is_a? Array
        attributes.collect { |a| type.build a }
      else
        nil
      end
    end
  end
end

