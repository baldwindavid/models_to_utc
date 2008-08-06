ActiveRecord::Base.send(:include, Bilson::TimestampColumns)
ActiveRecord::Migration.send(:include, Bilson::ModelsToUtc)