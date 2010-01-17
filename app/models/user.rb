class User
  include DataMapper::Resource
  
  property :id,               Serial
  property :username,         String
  property :time_zone,        String, :default => 'UTC'
  
  validates_with_block :time_zone do 
    ActiveSupport::TimeZone.all.find{|zone| zone.name == @time_zone}
  end
  

  has 1, :budget
end
