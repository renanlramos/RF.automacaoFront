*** Settings ***
Library       SeleniumLibrary
Library       DatabaseLibrary
Library       Collections
Library        ./resources.py

Resource        ./variables.resource


*** Keywords ***
Setup
    Connect To Database    pymysql    db_name=dev   db_user=root    db_password=password1    db_host=localhost   db_port=3306
    
    ${firefox_configs}=    Get Firefox Geolocation Capabilities    -23.5505    -46.6333
    Open Browser    about:blank    headlessfirefox    options=${firefox_configs}
    #Open Browser    about:blank    chrome    options= add_argument("--disable-popup-blocking");add_argument("--disable-infobars");add_argument("--disable-notifications"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--window-size=1280,720");

Teardown settings
    Close All Browsers
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

When user adds "${qtd}" items to his cart
    Wait Until Page Contains Element    xpath:(//button[@class="btn btn_primary btn_small btn_inventory "])
    Convert To Integer    ${qtd}
    FOR    ${index}    IN RANGE     0    ${qtd}
        Click Element    xpath:(//button[@class="btn btn_primary btn_small btn_inventory "])
    END
    
And check the cart items count are "${qtd}"
    Element Text Should Be    xpath://span[@class="shopping_cart_badge"]    ${qtd}


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
    Then remove all items by clicking on each product remove button

And proceeds to checkout and fills personal information
    Click Element    id:shopping_cart_container
    Wait Until Element Is Visible    id:cart_contents_container
    Click Element    xpath://button[@id="checkout"]
    Wait Until Element Is Visible    xpath://div[@class="checkout_info"]
    Input Text    id:first-name    Luca
    Input Text    id:last-name    Dart
    Input Text    id:postal-code    13460000
    Click Element    id:continue

Then check total amount, taxes and finalize it
    ${count}    Get Element Count    //div[@class="cart_item"]
    ${cart_total}=    Set Variable    0.0
    FOR    ${i}    IN RANGE    1    ${count + 1}
        ${cart_text}    Get Text    xpath:(//div[@class="item_pricebar"])[${i}]
        ${cart_value}    Evaluate    float('${cart_text}'.replace("$", ""))
        ${cart_total}    Evaluate    ${cart_total} + ${cart_value}
    END
    ${tax_calc}    Evaluate    round(${cart_total} * 0.08, 2)
    ${tax_text}    Get Text    css:.summary_tax_label
    ${tax_sys_value}    Evaluate    float('${tax_text}'.replace("Tax: $", ""))
    Should Be Equal    ${tax_calc}    ${tax_sys_value}

Geolocation Chrome Example
    Set Geolocation    -23.524839    -46.630386    100  
    Open Browser    https://webbrowsertools.com/geolocation/    chrome
    Element Should Contain    id:latitude    -23.524839 Degrees
    Element Should Contain    id:longitude    -46.630386 Degrees

Geolocation Firefox Example
    Go To    https://webbrowsertools.com/geolocation/
    Sleep    5
    Element Should Contain    id:latitude     -23.5505 Degrees
    Element Should Contain    id:longitude    -46.6333 Degrees