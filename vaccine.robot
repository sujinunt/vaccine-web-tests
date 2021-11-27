*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Suite Teardown     Close Browser

*** Variable ***
${url_service}                     https://vaccine-haven.herokuapp.com/
${title_service_taker}             Vaccine Haven
${text_create_account}             Citizen Registration
${text_vaccine_reservation}        Vaccine Reservation
${btn_my_info}                     //a[@id="nav__info__link"]
${btn_dropdown}                    //text[@class="white nav-dropdown-link"]
${btn_reserve}                     //a[@id="nav__reserve__link"]
${btn_submit_reserve}              //button[@id="reserve__btn"]
${btn_submit_info}                 //button[@id="info__btn"]
${btn_cancel}                      //*[@id="cancel__btn"]
${input_citizen_id}                //*[@placeholder="Citizen ID"]
${input_site}                      //*[@placeholder="Choose Site"]
${input_vaccine}                   //*[@placeholder="Choose Vaccine"]
${citizen_id}                      9601054595190
${site}                            OGYHSite
${vaccine}                         Pfizer
${verify_reserve}                  //*[@id="reserve_vaccine_value"][contains(text(),'Pfizer')]


*** Keywords ***
Verify vaccine-haven title page
    [Arguments]                    ${title}
    Title Should Be                ${title}
Verify vaccine-haven element page
    [Arguments]                    ${expected_text}         ${expected_text}
    Page Should Contain            ${expected_text}
    Page Should Contain            ${expected_text}
Click Button
     [Arguments]                   ${btn}
     Click Element                 ${btn}
Click Button Reservation
     [Arguments]                   ${btn}                   ${nav_item}
     Click Element                 ${btn}
     Click Element                 ${nav_item}
Input ID
     [Arguments]                   ${xpath}                 ${input_text}
     Element Should Be Visible     ${xpath}
     Input Text                    ${xpath}                 ${input_text}

Select List in Create Reservation
     [Arguments]      ${xpath1}    ${xpath2}                ${input_text1}     ${input_text2}      ${btn}
     Element Should Be Visible     ${xpath1}
     Element Should Be Visible     ${xpath2}
     Select from list by value     ${xpath1}                ${input_text1}
     Select from list by value     ${xpath2}                ${input_text2}
     Click Element                 ${btn}

Verify Reservation Success
   [Arguments]                     ${xpath}
   Element Should Be Visible       ${xpath}

*** Test Cases ***
Test Reservation
    Open Browser    about:blank    chrome
    Go To                                    ${url_service}
    Set Selenium Speed  1 seconds
    Verify vaccine-haven title page          ${title_service_taker}
    Verify vaccine-haven element page        ${text_create_account}        ${text_vaccine_reservation}
    Click Button Reservation                 ${btn_dropdown}               ${btn_reserve}
    Input ID                                 ${input_citizen_id}           ${citizen_id}
    Select List in Create Reservation        ${input_site}                 ${input_vaccine}         ${site}        ${vaccine}     ${btn_submit_reserve}
    Click Button                             ${btn_my_info}
    Input ID                                 ${input_citizen_id}           ${citizen_id}
    Click Button                             ${btn_submit_info}
    Verify Reservation Success               ${verify_reserve}
Test Cancel Reservation
    Click Button                             ${btn_cancel}