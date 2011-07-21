module Sunspot
  module Search
    # 
    # Hit Group a grouped set of hits
    # 
    class Group

      attr_reader :group_value, :matches, :hits, :num_found

      def initialize(raw_group, setup, search) #:nodoc:
        @group_value = raw_group['groupValue']
        @num_found = raw_group['doclist']['groupValue']
        @start     = raw_group['doclist']['start']
        @docs      = raw_group['doclist']['docs']
        
        @search    = search
      end
      
      def hits
        @hits ||=
          begin
            @docs.map do |raw|
              Hit.new(raw, nil, @search)
            end
          end
      end
      
      def results
        @results ||= PaginatedCollection.new(verified_hits.map { |hit| hit.instance }, @search.query.page, @search.query.per_page, num_found)
      end
      
      protected
      def verified_hits
        hits.select { |hit| hit.instance }
      end
    end
  end
end
