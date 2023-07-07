*** Settings ***
Documentation    File Operations
Library    OperatingSystem

*** Keywords ***
Wait Until File Exists
    [Documentation]    Waits for the file to be downloaded for the specified time.
    [Arguments]    ${path}    ${timeout}=10s

    Wait Until Keyword Succeeds    ${timeout}    1s    File Should Exist    ${path}
