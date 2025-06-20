*** Settings ***
Library       SeleniumLibrary
Library       DatabaseLibrary
Library       Collections
Library        ./resources.py

Resource        ./variables.resource


*** Keywords ***
Setup
    Connect To Database    pymysql    db_name=dev   db_user=root    db_password=password1    db_host=localhost   db_port=3306
    Open Browser    about:black    chrome    options= add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--window-size=1280,720");
    #sempre antes de commit incluir add_argument("--headless");

Teardown settings
    Disconnect From Database

Given the user is in login page
    Go To    ${LOGIN URL}
    Title Should Be    Swag Labs

And the user enters a valid standard credentials
    When the user enters a valid standard credentials
    
When the user enters a valid standard credentials
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

Then check all filterings options
    Wait Until Element Is Visible    class:select_container
    @{opt_list}    Create List    az    za    lohi    hilo

    FOR    ${opt}    IN    @{opt_list}
        IF    '${opt}' == 'az' or '${opt}' == 'za'
            ${locator}    Set Variable    css:.inventory_item_name
            ${locator2}    Set Variable    xpath://*[@class="inventory_item_description"]//div/a/div[1]
        ELSE
            ${locator}    Set Variable    css:.inventory_item_price
            ${locator2}    Set Variable    xpath://*[@class="pricebar"]//div
        END

        Select From List By Value    class:product_sort_container    ${opt}
        Sleep    1
        @{elements}    Get WebElements    ${locator}
        @{values_text}    Create List

        FOR    ${el}    IN    @{elements}
            ${values}    Get Text    ${el}
            Append To List    ${values_text}    ${values}
        END
        
        ${firstitem}     Get From List    ${values_text}    0
        ${text}    Get Text    ${locator2}
        Should Be Equal    ${text}    ${firstitem}
    END

And reloads the page
    Reload Page

Then the cart must be with the same itens
    Wait Until Element Is Enabled    xpath://span[@class="shopping_cart_badge"]
    ${text}    Get Text    xpath://span[@class="shopping_cart_badge"]
    ${convert}    Convert To Integer    ${text}
    ${count}    Get Element Count    xpath://button[@class="btn btn_secondary btn_small btn_inventory "]
    Should Be Equal    ${convert}    ${count}

Geolocation Example
    Set Geolocation    -23.524839    -46.630386    100  
    Go To    https://webbrowsertools.com/geolocation/
    Element Should Contain    id:latitude    -23.524839 Degrees
    Element Should Contain    id:longitude    -46.630386 Degrees
    