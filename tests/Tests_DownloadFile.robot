*** Settings ***
Documentation    Tests of Downloading File with Link
Resource  ../resources/ProjectInterface.robot

Suite Setup    Start Suite
Suite Teardown    Finish Suite

*** Test Cases ***
Download Sample Data File
    [Tags]    file    regression
    When Click File Link
    Then Validate File Download
