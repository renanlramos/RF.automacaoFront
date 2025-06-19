*** Settings ***
Library             SeleniumLibrary
Resource            ../src/keywords.robot
Test Teardown       Close Browser


*** Test Cases ***
Login Válido
    Dado que esteja logado
    Quando insiro o usuário "standard_user"
    E insiro a senha "secret_sauce"
    E clico em login
    Então deve ser exibido a página de produtos


