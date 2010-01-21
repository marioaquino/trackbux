class Budget
  include DataMapper::Resource
  
  property :id, Serial
  property :period, Time, :default => lambda { 1.week.from_now.at_midnight }
  property :amount, BigDecimal, :precision => 8, :scale => 2, :default => lambda {|budget, property| 
    budget.user.default_budget_amount
  }
  
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
  
  def remaining_funds
    amount - total_expenses
  end
  
  def percent_remaining
    return 0.0 if amount == 0.0
    (remaining_funds / amount) * 100
  end
end
