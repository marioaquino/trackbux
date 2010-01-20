module ModelUpgrader

  def self.upgrade
    Expense.auto_upgrade!
    Budget.auto_upgrade!
    User.auto_upgrade!  
  end

end
