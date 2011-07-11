module Sunspot
  module Search
    # 
    # Hit Group a grouped set of hits
    # 
    class Group

      attr_reader :hits, :num_found

      def initialize(raw_group, search) #:nodoc:
        @raw       = raw_group
        @value     = @raw['groupValue']
        @doclist   = @raw['doclist']
        @num_found = @doclist['numFound']
        @search    = search
      end

      def hits
        @hits ||=
          begin
            @doclist['docs'].map do |raw|
              Hit.new(raw, nil, @search)
            end
          end
      end
    end
  end
end
