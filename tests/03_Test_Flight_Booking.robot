*** Settings ***
Documentation    Test Suite for Booking.com - Hotel Booking
Library         SeleniumLibrary
Resource        ../resources/variables.robot
Resource        ../resources/common.robot


*** Variables ***
${flight_one_way}               //label[@for='search_type_option_ONEWAY']/span[2]
${flight_source_xpath}          //button[@data-ui-name='input_location_from_segment_0']
${flight_dest_xpath}            //button[@data-ui-name='input_location_to_segment_0']
${place_input_field}            //input[@placeholder='Airport or city']


${flight_search_button_xpath}       //button/span[text()='Search']
${direct_filter_xpath}              //div[@data-testid='search_filter_stops_radio_Direct only']//span[2]

${next_button_xpath}                //button/span[text()='Next']

*** Test Cases ***

TC01_Search_for_flight_one_way
    [Documentation]    Ensure that users can search flights, as per their need

    Open Booking.com
    delete all cookies
    Navigate to Flights Section

    # Selct one-way flight
    click element       xpath=${flight_one_way}

    # Enter the reqiored details for flight search
    click element       ${flight_source_xpath}
    click element       xpath=//button[@data-autocomplete-chip-idx='0']/span/span[2]
    input text          ${place_input_field}        maa
    wait until page contains element            xpath=//input[@name='AIRPORTMAA']           ${web_element_timeout}
    click element       xpath=//input[@name='AIRPORTMAA']/parent::div/label/span[2]
    press key           ${place_input_field}        ENTER
    click element       ${flight_dest_xpath}
    input text          ${place_input_field}        del
    wait until page contains element            xpath=//input[@name='AIRPORTDEL']           ${web_element_timeout}
    click element       xpath=//input[@name='AIRPORTDEL']/parent::div/label/span[2]
    press key           ${place_input_field}        ENTER
    click element    css=${flight_calendar_css}
    click element    xpath=//td/span[@aria-label=${desired_checkin_date}]
    click element                       xpath=${flight_search_button_xpath}
    wait until page contains element         xpath=//div[@id='flightcard-0']        ${web_element_timeout}

TC02_Filter_search_with_zero-stop
    [Documentation]    Ensure users can filter flight results based on zero stops

    click element       xpath=${direct_filter_xpath}
    wait until page contains element         xpath=//div[@id='flightcard-0']//span[text()='Direct']         ${web_element_timeout}


TC03_Book_flight_ticket
    [Documentation]    Ensure users can book a flight

    click element          xpath=//div[@id='flightcard-0']//button/span[text()='View details']
    wait until element is visible          xpath=//div[@role='dialog']//h2[text()='Your flight to New Delhi']         ${web_element_timeout}
    click element           xpath=//button/span[text()='Select']
    wait until element is visible           xpath=//div[text()='Standard ticket']               ${web_element_timeout}
    click element            xpath=//button[@data-testid='ticket_type_cta_standard']/span[text()='Continue']
    wait until page contains element                xpath=//h2[text()='Enter your details']         ${web_element_timeout}

    input text              xpath=//input[@name='booker.email']             ${email}
    input text              xpath=//input[@name='number']                   ${phone_number}

    click element           xpath=//button/span[text()='Add this traveler’s details']
    wait until element is visible       xpath=//label//span[text()='First names']
    input text          xpath=//input[@name='passengers.0.firstName']           ${first_name}
    input text          xpath=//input[@name='passengers.0.lastName']            ${last_name}

    click element       xpath=//select[@name='passengers.0.gender']
    select from list by value           xpath=//select[@name='passengers.0.gender']         female
    click element        xpath=//button/span[text()='Done']
    wait until page contains element            xpath=${next_button_xpath}                  ${web_element_timeout}
    click element         xpath=${next_button_xpath}
    wait until page contains element            xpath=//h2[text()='Select your seat']       ${web_element_timeout}
    click element       xpath=//button/span[text()='Skip']
    wait until page contains element            xpath=//h3[text()='Your payment']           ${web_element_timeout}









