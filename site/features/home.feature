Feature: View budget tracker

	Scenario: Unauthenticated user views homepage
	Given I visit "/"
	And I am not authenticated
	Then I should see "Please login using one of these login credentials"
	
	