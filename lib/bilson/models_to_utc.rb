module Bilson
  module ModelsToUtc
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      
      def models_to_utc(models, from_time_zone, revert = false)
        models = models.to_a
        models.each do |model|    
          model.all.each do |record|
            timestamps = {}        
            model.timestamp_columns.each do |column|
              rc = record.send(column.name)
              if rc.blank?
                timestamps[column.name] = rc
              else
                add_or_subtract = revert == true ? '+' : '-'  
                timestamps[column.name] = rc.utc.send(add_or_subtract, rc.in_time_zone(from_time_zone).utc_offset)
              end
            end
            record.update_attributes(timestamps)
          end
        end
      end
      
      def revert_models_to_utc(models, from_time_zone)
        models_to_utc(models, from_time_zone, true)
      end
      
    end
    
  end 
end