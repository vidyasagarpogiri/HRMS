Feature: Employee Signup
    In order to test the application
        
@javascript
Scenario: Adds a New Employee
				#Given there are departments seeded
        Given I am on the new_profile page
        And I fill in "employee_employee_id" with "3456"
        And I fill in "employee_date_of_join" with "12-02-2006"
        When I select "Mrs" from "employee_title"
        And I fill in "employee_first_name" with "First Name"
        And I fill in "employee_last_name" with "Last Name"
				And I fill in "employee_date_of_birth" with "12-02-2006"
				When I choose "employee_gender_female"
				When I choose "employee_marital_status_unmarried"
				And I fill in "employee_total_experience" with "5"
				When I choose "employee_status_false"
				And I fill in "employee_mobile_number" with "9879876589"
				And I fill in "employee_father_name" with "father name"
      	And I fill in "employee_pan" with "father name"
				And I fill in "employee_date_of_join" with "19-02-2009"
				And I fill in "employee_date_of_confirmation" with "19-02-2009"
				And I fill in "employee_date_of_exit" with "19-02-2013"
				When I select "HR" from "employee[department_id]"
        When I press "Submit"
				

