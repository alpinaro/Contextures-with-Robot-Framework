*** Settings ***
Documentation    Operations on Collections
Library    Collections

*** Keywords ***
Count List Elements in Groups
    [Documentation]    Groups identical elements in the given list and finds the number of matches.
    # [Documentation]    Returns: groups{group:repetition}
    [Arguments]    ${list}

    ${groups}    Evaluate    dict(collections.Counter(${list}))
    [Return]    ${groups}

Find List Element Indexes of Less Than Value
    [Documentation]    Returns a list of indexes of list elements smaller than the given value.
    [Arguments]    ${list}    ${value}

    ${indexes}    Create List

    FOR    ${index}    IN RANGE    0    ${list.__len__()}
        Run Keyword If    ${list}[${index}] < ${value}    Append To List    ${indexes}    ${index}
    END
    [Return]    @{indexes}

Find List Element Indexes of Maximum Value
    [Documentation]    Returns a list of indexes of list elements at maximum value.
    [Arguments]    ${list}

    ${indexes}    Create List
    ${list_numeric}    Evaluate    [float(item) for item in ${list}]
    ${max}    Evaluate    max(${list_numeric})

    FOR    ${index}    IN RANGE    ${list_numeric.__len__()}
        Run Keyword If    ${list_numeric}[${index}] == ${max}    Append To List    ${indexes}    ${index}
    END
    [Return]    @{indexes}

Find List Element Indexes of Equal Text
    [Documentation]    Returns a list of indexes of list elements equal the given text.
    [Arguments]    ${list}    ${value}

    ${indexes}    Create List

    FOR    ${index}    IN RANGE    0    ${list.__len__()}
        Run Keyword If    '${list}[${index}]' == '${value}'    Append To List    ${indexes}    ${index}
    END
    [Return]    @{indexes}

Create Sublist with Specific Indexes
    [Documentation]    Returns a list of elements only at the specified indexes of the given list.
    [Arguments]    ${list}    ${indexes}

    @{sublist}    Create List

    FOR    ${index}    IN    @{indexes}
        ${item}    Get From List    ${list}    ${index}
        Append To List    ${sublist}    ${item}
    END
    [Return]    @{sublist}
