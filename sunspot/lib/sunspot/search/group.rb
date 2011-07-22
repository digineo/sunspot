module Sunspot
  module Search
    # 
    # Hit Group a grouped set of hits
    # 
    class Group

      attr_reader :group_value, :matches, :hits, :num_found

      def initialize(raw_group, setup, search) #:nodoc:
        @group_value = raw_group['groupValue']
        @num_found = raw_group['doclist']['numFound']
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
        @results ||= PaginatedCollection.new(verified_hits.map { |hit| hit.instance }, group_page, group_limit, num_found)
      end
      
      protected
      def verified_hits
        hits.select { |hit| hit.instance }
      end
      
      def group_limit
        @search.query["group.limit"] || 1
      end
      
      def group_offset
        @search.query["group.offset"] || 0
      end
      
      def group_page
        (group_offset/group_limit + 0.5 ).to_i + 1
      end
    end
  end
end
