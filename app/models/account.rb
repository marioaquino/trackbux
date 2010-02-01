class Account
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :default => 'Default' #FIXME: Localization
  property :currency, String
  
  has n, :budgets, :order => [ :period.asc ]
  
  has n, :users, :through => Resource
  
  before :save do
    currency ||= users.first.try(:default_currency)
  end
  
  def currency
    attribute_get(:currency) || users.first.try(:default_currency)
  end
  
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
