class User
  include DataMapper::Resource
  
  property :id,               Serial
  property :username,         String
  property :time_zone,        String, :default => 'UTC'
  
  validates_with_block :time_zone do 
    ActiveSupport::TimeZone.all.find{|zone| zone.name == @time_zone}
  end

  has n, :budgets, :order => [ :period.asc ]
  
  def time_zone=(value)
    attribute_set(:time_zone, value.split(/\)\s/).last)
  end
  
  def latest_budget
    budgets.last
  end
end
