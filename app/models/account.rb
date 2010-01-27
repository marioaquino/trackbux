class Account
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :default => 'Default' #FIXME: Localization
  
  has n, :budgets, :order => [ :period.asc ]
  
  has n, :users, :through => Resource
  
  def latest_budget
    budgets.last
  end
  
  def time_zone
    users.first.time_zone
  end
  
  def default_budget_amount
    users.first.default_budget_amount
  end
end
