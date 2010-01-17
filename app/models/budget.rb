class Budget
  include DataMapper::Resource
  
  property :id, Serial
  property :period, Time, :default => lambda { 1.week.from_now.at_midnight }
  
  belongs_to :user
  
  def period
    attribute_get(:period).in_time_zone(user.time_zone)
  end
end

