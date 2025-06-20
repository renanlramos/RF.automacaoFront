*** Settings ***
Library             SeleniumLibrary
Library             DatabaseLibrary
Resource            ../src/keywords.resource

Suite Setup         Setup
Test Teardown       Close Browser     
Suite Teardown      Teardown settings


*** Test Cases ***
Valid Login
    [Tags]    CT001
    Given the user is in login page
    When the user enters a valid standard credentials
    And click in login button
    Then must be redirect to the product page

Invalid Credentials
    [Tags]    CT002
    Given the user is in login page
    When the user enters a invalid credentials
    And click in login button
    Then an error message should be displayed

Add and remove products from cart
    [Tags]    CT003
    Given the user is in login page
    And the user enters a valid standard credentials
    And click in login button
    When user adds items to his cart
    And check the cart items count
    Then remove all items by clicking on each product remove button

Filtering options
    [Tags]    CT004
    Given the user is in login page
    When the user enters a valid standard credentials
    And click in login button
    Then check all filterings options

Persisting cart after reload
    [Tags]    CT005
    Given the user is in login page
    And the user enters a valid standard credentials
    And click in login button
    When user adds items to his cart
    And reloads the page
    Then the cart must be with the same itens

Geolocation test
    Geolocation Example