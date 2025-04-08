
*** Settings ***
Documentation    Test Suite for Booking.com - Authentication
Library         SeleniumLibrary
Resource        ../resources/variables.robot
Resource        ../resources/common.robot


*** Variables ***


*** Keywords ***
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


*** Test Cases ***

TC01_User_Registration
    [Documentation]     Ensure users can register successfully

    Open Booking.com
    click element    link=Register
    input text    name=username    ${email}
    click button    css=button[type='submit']
    wait until page contains element    xpath=//h1

    sleep       ${web_element_timeout}
    ${code} =    Get Verification Code From Email
    Log     ${code}

    switch browser      booking
    FOR    ${i}    IN RANGE      6
        input text      xpath=//input[@name='code_${i}']        ${code}[${i}]
    END

    click button        xpath=//button[@type='submit']

    close browser


