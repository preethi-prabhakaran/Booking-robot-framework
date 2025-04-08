# Booking-robot-framework

This is an end-to-end automation of registration, flight booking and hotel booking functionalities in Booking.com using Robot Framework and Selenium. It simulates real-world scenarios for testing a travel booking platform, including handling dynamic UI elements, multiple tabs, OTP-based new user registration, dropdowns, calendar widgets, and form submissions.
Tools & Technologies:
	•	Python, Robot Framework
	•	SeleniumLibrary – for browser automation
	•	Regex based validation for OTP retrieval
	•	WebDriver (ChromeDriver)
	•	Modular folder structure for better test maintenance and reusability
Key Functional Areas Covered:
1.	New User Registration:
	•	Navigates to the registration page and enters a new email ID
	•	Opens Yopmail in a new tab and retrieves the OTP
	•	Fills OTP into the respective fields (one-by-one)
	•	Handles switching between browser windows for OTP verification
2.	Flight Booking:
	•	Navigates to the "Flights" section from the Booking.com homepage
	•	Inputs origin, destination cities, and selects the travel dates from the calendar widget
	•	Applies filters like non-stop/direct flights
	•	Validates the navigation till payment page
3.	Hotel Booking:
	•	Navigates to "Stay" section from the homepage
	•	Selects check-in and check-out dates from the calendar
	•	Initiates hotel search and waits for search results
	•	Applies filters (no prepayment)
	•	Selects a hotel and room type from the results
	•	Proceeds to booking summary and enter traveller details
	•	Validates booking confirmation page



