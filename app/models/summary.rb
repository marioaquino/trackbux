class Summary
  attr_reader :amount_spent, :budget, :amount_remaining, :end_date, 
              :percentage_used
                
  def initialize(budget)
    @currency = budget.currency
    @amount_spent = money(budget.total_expenses)
    @budget = money(budget.amount)
    @amount_remaining = money(budget.remaining_funds)
    @end_date = budget.period.strftime("%m/%d/%Y")
    @percentage_used = budget.percent_used
  end
  
  private 
  def money(value)
    Money.new(value * 100, @currency).format
  end
end
