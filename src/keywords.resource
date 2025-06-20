*** Settings ***
Library       SeleniumLibrary
Library       DatabaseLibrary
Library       Collections
Library        ./resources.py

Resource        ./variables.resource


*** Keywords ***
Setup
    Connect To Database    pymysql    db_name=dev   db_user=root    db_password=password1    db_host=localhost   db_port=3306
    Open Browser    about:black    chrome    options=add_argument("--headless"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--window-size=1280,720");
    #sempre antes de commit incluir add_argument("--headless");

Teardown settings
    Disconnect From Database

Given the user is in login page
    Go To    ${LOGIN URL}
    Title Should Be    Swag Labs

And the user enters valid credentials
    When the user enters valid credentials
    
When the user enters valid credentials
    ${results}    Query    SELECT name, password from dev.tb_users WHERE id = 8
    ${first_line}    Get From List    ${results}    0
    ${username}    Get From List    ${first_line}    0
    ${password}    Get From List    ${first_line}    1
    Input Text    id:user-name    ${username}
    Input Text    id:password    ${password}

And click in login button
    Click Button    id:login-button

Then must be redirect to the product page
    Wait Until Element Is Visible    id:header_container
    Page Should Contain Element    //*[text()='Products']

When the user enters a invalid credentials
    Input Text    id:user-name    abc
    Input Text    id:password    123

Then an error message should be displayed
    Wait Until Element Is Visible    class:error-button
    Page Should Contain Element    xpath://*[text()="Epic sadface: Username and password do not match any user in this service"]
    Click Element   class:error-button
    Page Should Not Contain Element    class:error-button

When user adds items to his cart
    Wait Until Page Contains Element    xpath:(//button[@class="btn btn_primary btn_small btn_inventory "])
    ${qtd}    Get Element Count    xpath:(//button[@class="btn btn_primary btn_small btn_inventory "])
    FOR    ${index}    IN RANGE     1    ${qtd + 1}
        Click Element    xpath:(//button[@class="btn btn_primary btn_small btn_inventory "])
    END
    
And check the cart items count
    Element Should Be Visible    xpath://span[@class="shopping_cart_badge" and text()="6"]


Then remove all items by clicking on each product remove button
    Wait Until Page Contains Element    xpath:(//button[@class="btn btn_secondary btn_small btn_inventory "])
    ${qtd}    Get Element Count    xpath:(//button[@class="btn btn_secondary btn_small btn_inventory "])
    FOR    ${index}    IN RANGE     1    ${qtd + 1}
        Click Element    xpath:(//button[@class="btn btn_secondary btn_small btn_inventory "])
    END

Geolocation Example
    Set Geolocation    -23.524839    -46.630386    100  
    Go To    https://webbrowsertools.com/geolocation/
    Element Should Contain    id:latitude    -23.524839 Degrees
    Element Should Contain    id:longitude    -46.630386 Degrees
    