class User
  include DataMapper::Resource
  
  property :id,                    Serial                   
  property :username,              String                   
  property :time_zone,             String, :default => 'UTC'
  property :default_budget_amount, BigDecimal, :default => 0.0, :precision => 8, :scale => 2
  
  validates_with_block :time_zone do 
    ActiveSupport::TimeZone.all.find{|zone| zone.name == @time_zone}
  end

  has 1, :default_account, "Account"
  has n, :accounts, :through => Resource
  
  after :default_account= do
    default = default_account
    add_account(default) unless accounts.include?(default)
  end
  
  def time_zone=(value)
    attribute_set(:time_zone, value.split(/\)\s/).last)
  end
  
  def add_account(account)
    self.accounts << account
    account.users << self
    self.default_account ||= account
  end
end
