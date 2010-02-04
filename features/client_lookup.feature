Feature: Mobile client interaction

	Scenario: Requesting a budget summary
		Given I am authenticated as "test_user1"
		And I ask for the budget summary
		Then I should get "$45.50" for "amount_spent"
		And I should get "$2,000.00" for "budget"
		And I should get "$1,954.50" for "amount_remaining"
		And I should get a date of "2.weeks.from_now" for "end_date" in "%m/%d/%Y" format
		And I should get 2.275 for "percentage_used"
		
	Scenario: Adding an expense
		Given I am authenticated as "test_user1"
		And I add an expense of "78.23"
		Then I should get "$123.73" for "amount_spent"
		And I should get "$2,000.00" for "budget"
		And I should get "$1,876.27" for "amount_remaining"
		And I should get a date of "2.weeks.from_now" for "end_date" in "%m/%d/%Y" format
		And I should get 6.1865 for "percentage_used"
