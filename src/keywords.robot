*** Settings ***
Library        SeleniumLibrary
Library        String
Resource        ./variables.robot

*** Keywords ***
Dado que esteja logado
    Open Browser    ${LOGIN URL}    chrome    options=add_argument("--headless"); add_argument("--no-sandbox"); add_argument("----disable-dev-shm-usage")
    Title Should Be    Swag Labs

Quando insiro o usuário "${username}"
    Input Text    id:user-name    ${username}

E insiro a senha "${password}"
    Input Text    id:password    ${password}

E clico em login
    Click Button    id:login-button

Então deve ser exibido a página de produtos
    Page Should Contain Element    //*[text()='Products']
    