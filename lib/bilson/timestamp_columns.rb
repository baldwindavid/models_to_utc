module Bilson
  module TimestampColumns
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      
      def timestamp_columns
        @timestamp_columns ||= columns.select { |c| c.type == :timestamp || c.type == :datetime }
      end
      
    end
    
  end 
end
