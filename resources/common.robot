*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot
Library    SeleniumLibrary


*** Variables ***
${page_text}        'Booking.com'
${title_text}       Booking.com | Official site | The best hotels, flights, car rentals & accommodations
${xpath_page_text}  //a[@aria-label=${page_text}]

${hotel_calendar_css}                 div[data-testid="searchbox-dates-container"]
${flight_calendar_css}             button[data-ui-name='button_date_segment_0']
${desired_date_xpath}                 //td/span[@aria-label='3 March 2026']

*** Keywords ***
Open Booking.com
    open browser    ${url}    ${browser}        alias=booking
    maximize browser window
    wait until element is visible    xpath=${xpath_page_text}
    title should be         ${title_text}

Get Verification Code From Email
    open browser        ${yopmail}      ${browser}      alias=yopmail
    maximize browser window
    wait until element is visible       id=login
    input text          id=login        ${email}
    click button        xpath=//button[@class='md']

    select frame    id=ifinbox
    #wait until element is visible           xpath=//iframe
    click element       xpath=//div[@currentmail]
    unselect frame

    select frame    id=ifmail
    ${email_body}=       get text        xpath=//body
    ${otp}=         should match regexp         ${email_body}      [(?i)A-Z0-9]{6}
    Log         OTP: ${otp}
    unselect frame
    close browser
    RETURN      ${otp}

Dismiss Genius Banner If Present
    ${banner_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@aria-label='Window offering discounts of 10% or more when you sign in to Booking.com']         ${web_element_timeout}
    Run Keyword If    ${banner_present}    Click Element    xpath=//button[contains(@aria-label, "Dismiss") or contains(@class, "close")]

Navigate to Flights Section
    click link    id=flights

Navigate to Stay Section
    click link    id=accommodations

Select two Dates From Calendar
    [Documentation]    Selects date from the calendar
    [Arguments]          ${calendar_css}           ${desired_first_date}        ${desired_second_date}='None'
    click element    css=${calendar_css}
    run keyword if    '${calendar_css}' == '${hotel_calendar_css}'              wait until element is visible       xpath=//button[@id='calendar-searchboxdatepicker-tab-trigger']          ${web_element_timeout}
    click element    xpath=//td/span[@aria-label=${desired_first_date}]
    run keyword if      ${desired_second_date} != 'None'      click element    xpath=//td/span[@aria-label=${desired_second_date}]

