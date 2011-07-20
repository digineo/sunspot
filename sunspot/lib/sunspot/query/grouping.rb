module Sunspot
  module Query
    # 
    # A query component that holds information about grouping.
    #
    class Grouping #:nodoc:
      @@known_options = {
        :limit => true,
        :sort  => true
      }.freeze
      
      attr_reader :field, :options

      def initialize(field = nil, options = {})
        self.field, self.options = field, options
      end

      def to_params
        # each given option key "namespaced"
        Hash[ *options.collect{ |k,v| [:"group.#{k}", v] }.flatten ].merge( :group => true, :"group.field" => field.indexed_name )
      end

      def field=(field)
        @field = field if field
      end

      def options=(options)
        for key, value in options
          raise ArgumentError, "Unknown option #{key.inspect}" unless @@known_options[key]
        end
        
        @options = options if options
      end

    end
  end
end
