*** Settings ***
Documentation    Test Suite for Booking.com - Hotel Booking
Library         SeleniumLibrary
Resource        ../resources/variables.robot
Resource        ../resources/common.robot


*** Variables ***

${hotel_destination}            New Delhi
${hotel_destination_xpath}      //input[@placeholder="Where are you going?"]


${price_slider_xpath}       //div[@data-testid="filters-group-slider"]//input[@type='range']
${updated_filter_xpath}     //label[@data-testid="filter:price=INR-min-3600-1"]

${first_hotel_xpath}        //div[@data-testid='property-card'][1]//span[text()='See availability']
${hotel_overview_xpath}     //ul[@role='tablist']//span[text()='Overview']
${reserve_button_xpath}     //button/span[text()='Reserve']



*** Test Cases ***
TC01_Search_for_hotel
    [Documentation]     Ensure users can search for hotels

    Open Booking.com
    Dismiss Genius Banner If Present
    Navigate to Stay Section
    Dismiss Genius Banner If Present
    input text    xpath=${hotel_destination_xpath}        ${hotel_destination}
    wait until element is visible           xpath=//div[text()='${hotel_destination}']        ${web_element_timeout}
    click element           xpath=//div[text()='${hotel_destination}']
    Select two Dates From Calendar      ${hotel_calendar_css}         ${desired_checkin_date}       ${desired_checkout_date}
    click button    xpath=//button[@type='submit']
    Dismiss Genius Banner If Present
    wait until element contains    xpath=//h1       properties found

TC02_Filter_hotel_with_noPrepayment
    [Documentation]    Ensure users can filter hotels based on the condition: No Prepayment

    click element           xpath=//div[@data-filters-item='popular:fc=5']/label/span[2]
    wait until element is visible           xpath=//button[@aria-label='No prepayment']


TC03_Book_Hotel
    [Documentation]     Ensure users can successfully book a hotel

    click element    ${first_hotel_xpath}
    ${window_handles}       get window handles
    switch window       ${window_handles}[1]
    wait until element is visible       ${hotel_overview_xpath}         ${web_element_timeout}
    #click element        xpath=${reserve_button_xpath}
    click element       xpath=//table[@id='hprt-table']//tbody/tr[1]/td[5]/div
    select from list by value           xpath=//select[@data-testid='select-room-trigger']          1
    click element        xpath=//span[@class='bui-button__text js-reservation-button__text']
    wait until element is visible    xpath=//h2[text()='Enter your details']
    input text          xpath=//input[@data-testid="user-details-firstname"]        automation
    input text          xpath=//input[@data-testid="user-details-lastname"]         testing
    input text          xpath=//input[@data-testid="user-details-email"]            ${email}
    input text          xpath=//input[@data-testid="phone-number-input"]            9999999999
    click element       xpath=//span[text()=' Next: Final details ']
    wait until element is visible           xpath=//span[text()=' Complete booking ']           ${web_element_timeout}
    click element       xpath=//span[text()=' Complete booking ']

    wait until element is visible       xpath=//h1[text()='Your booking in New Delhi is confirmed.']    ${web_element_timeout}








