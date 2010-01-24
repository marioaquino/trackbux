class User
  include DataMapper::Resource
  
  property :id,                    Serial                   
  property :username,              String                   
  property :time_zone,             String, :default => 'UTC'
  property :default_budget_amount, BigDecimal, :default => 0.0, :precision => 8, :scale => 2
  
  validates_with_block :time_zone do 
    ActiveSupport::TimeZone.all.find{|zone| zone.name == @time_zone}
  end

  has n, :accounts, :through => Resource
  
  def time_zone=(value)
    attribute_set(:time_zone, value.split(/\)\s/).last)
  end
  
  def default_account
    accounts.first
  end
end
