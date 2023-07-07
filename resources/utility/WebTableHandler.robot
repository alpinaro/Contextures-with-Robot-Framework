*** Settings ***
Documentation    HTML Web Table Operations
Library    SeleniumLibrary
Library    Collections
Resource    CollectionsResolver.robot

*** Keywords ***
Transform WebTable to Dictionary
    [Documentation]    Transforms a HTML web table given as locator to a dictionary of lists.
    # [Documentation]    Treats the first row of the table as the header and assigns the column names as dictionary keys.
    # [Documentation]    Converts the values in the columns to individual lists and saves them as values corresponding to these dictionary keys.
    [Arguments]    ${locator_table}

    ${dictable}    Create Dictionary
    ${locator_header}    Set Variable    ${locator_table}/tbody/tr[1]/td
    @{columns}    Get Webelements    ${locator_header}

    FOR    ${index}    IN RANGE    0    ${columns.__len__()}
        ${column_no}    Evaluate    ${index} + 1
        ${column}    Set Variable    ${columns}[${index}]
        ${header}    Get Text    ${column}
        ${locator_column}    Set Variable    ${locator_table}//td[${column_no}]/p
        @{column_items}    Get Webelements    ${locator_column}
        Remove From List    ${column_items}    0
        @{column_values}    Create List

        FOR    ${column_item}    IN    @{column_items}
            ${column_value}    Get Text    ${column_item}
            Append To List    ${column_values}    ${column_value}
        END
        Set To Dictionary    ${dictable}    ${header}    ${column_values}
    END
    [Return]    ${dictable}

Create SubTable with Row Indexes
    [Documentation]    Creates a sub dictable from the given dictable according to the specified index list.
    [Arguments]    ${dictable}    ${indexes}

    ${subdictable}    Create Dictionary
    ${keys}    Evaluate    list(${dictable}.keys())

    FOR    ${key}    IN    @{keys}
        @{value}    Create Sublist With Specific Indexes    ${dictable.${key}}    ${indexes}
        Set To Dictionary    ${subdictable}    ${key}    ${value}
    END
    [Return]    ${subdictable}

Find Groups in Column
    [Documentation]    Finds groups with the same value in the given column of the table.
    # [Documentation]    Returns: [group count, groups{group:repetition}]
    [Arguments]    ${column}

    ${groups}    Count List Elements In Groups    ${column}
    ${group_count}    Get Length    ${groups}
    ${group_list}    Create List    ${group_count}    ${groups}
    [Return]    ${group_list}
