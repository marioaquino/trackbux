Feature: Admin interface secured behind authentication
  In order to restrict unauthorized access to the site
  As an authorized user
  I want to gain access to the admin section of the website
  So that I can manage the publicly viewable content

  Scenario Outline: Unauthorized access to the admin root page
    Given I visit <admin_specific_path>
    And I am not authenticated
    Then I should be redirected to the "/login" page

	Examples:
		|admin_specific_path|
		|"/admin"|

  Scenario: Viewing the login page
    Given I visit "/login"
    Then I should see a "username" field
    And I should see a "password" field
    And I should see a "Sign in" button

  Scenario Outline: Logging into the admin page
	Given I visit "/login"
	And I login with username <username> and password <password>
	Then I should see <screen_content>
	And I should be on the <expected_target> page
	
	Examples:
		|username|password|screen_content  	|expected_target|
		|"admin" |"admin" |"Welcome, Admin"	|"/admin"|
		|"foo"   |"bar"   |"Incorrect username or password supplied"|"/unauthenticated"|

  Scenario: Logging out of the admin page
    Given I am logged in as "admin"
    And I click "logout"
    Then I should be on the "/" page
    And I should see "Budget Minder"
  