class Expense
  include DataMapper::Resource
  
  property :id, Serial
  property :amount, BigDecimal, :precision => 8, :scale => 2
  property :created_on, Time, :default => lambda { Time.now }
  
  belongs_to :budget
end
