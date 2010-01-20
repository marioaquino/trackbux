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

class Budget
  include DataMapper::Resource
  
  property :id, Serial
  property :period, Time, :default => lambda { 1.week.from_now.at_midnight }
  
  has n, :expenses
  belongs_to :user
  
  def period
    attribute_get(:period).in_time_zone(user.time_zone)
  end
  
  # TODO: Optimize to not calculate on every read. Cache total expenses
  # and update on add
  def total_expenses
    expenses.sum(:amount) || 0.0
  end
  
  def add_expense(amount)
    expenses.new(:amount => amount)
    expenses.save
  end
end

class Expense
  include DataMapper::Resource
  
  property :id, Serial
  property :amount, BigDecimal, :precision => 8, :scale => 2
  property :created_on, Time, :default => lambda { Time.now }
  
  belongs_to :budget
end

Expense.auto_upgrade!
Budget.auto_upgrade!
User.auto_upgrade!