module Sunspot
  module Search
    # 
    # A set of Groups
    # 
    class Grouped < Array
      attr_reader :matches, :field_name
      
      def initialize(field_name, solr_grouped, setup, search) #:nodoc:
        @field_name = field_name
        @matches    = solr_grouped["matches"]
        
        for raw_group in solr_grouped["groups"]
          self << Group.new(raw_group, setup, search)
        end
      end
    end
  end
end
