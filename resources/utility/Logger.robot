*** Settings ***
Documentation    Log Operations
Library    Collections

*** Keywords ***
Log Groups with Given List
    [Documentation]    Creates logs of groups with their names and quantities.
    [Arguments]    ${groups}

    Log    Column name: ${groups}[0]
    Log    How many different item types are there: ${groups}[1]
    Log    Types of items and their quantities: ${groups}[2]

Log Result Table as Dictionary
    [Documentation]    Creates logs of given dictionary.
    [Arguments]    ${subtable}    ${subcount}

    Log    How many records are in the result table: ${subcount}
    Log Dictionary    ${subtable}
