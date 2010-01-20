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
