module Sunspot
  module Search
    # 
    # A set of Groups
    # 
    class Grouped
      attr_reader :name, :matches
      
      def initialize(name, raw, search) #:nodoc:
        @name    = name
        @raw     = raw
        @search  = search
        @matches = raw['matches']
      end
      
      def groups
        @groups ||=
          begin
            @raw['groups'].map do |raw_group|
              Group.new(raw_group, @search)
            end
          end
      end
    end
  end
end
