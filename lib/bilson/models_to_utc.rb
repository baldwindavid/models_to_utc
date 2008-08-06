module Bilson
  module ModelsToUtc
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      
      def models_to_utc(models, from_time_zone = '')
        models = models.to_a
        models.each do |model|    
          model.find(:all).each do |record|
            timestamps = {}        
            model.timestamp_columns.each do |column|
              rc = record.send(column.name)
              timestamps[column.name] = !rc.blank? ? rc.utc - rc.in_time_zone(from_time_zone).utc_offset : rc
            end
            record.update_attributes(timestamps)
          end
        end
      end
      
    end
    
  end 
end