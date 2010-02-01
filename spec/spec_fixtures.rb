User.fix(:test_user1) {{
  :username => "test_user1"
}}

Account.fix {{
  :name => "Primary"
}}

Budget.fix {{
  # $44.50 total expenses
  :amount => 2000,
  :period => 2.weeks.from_now,
  :expenses => 2.of {Expense.make(:amount => 22.75)}
}}

Expense.fix {{
}}

User.gen(:test_user1).tap { |user| 
  user.add_account(Account.gen)
  Budget.gen(:account => user.default_account)
  user.save
}
