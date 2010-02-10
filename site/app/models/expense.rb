class Expense
  include DataMapper::Resource
  
  property :id, Serial
  property :amount, BigDecimal, :precision => 8, :scale => 2
  property :created_at, DateTime, :default => Proc.new { Time.now }
  
  belongs_to :budget
end
