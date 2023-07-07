*** Settings ***
Documentation    Interface that communicates with utility and handles actions based on project requirements
Resource    utility/CollectionsResolver.robot
Resource    utility/FileHandler.robot
Resource    utility/Logger.robot
Resource    utility/WebTableHandler.robot

*** Variables ***
${url}    https://contextures.com/xlsampledata01.html#data

${locator_frame_cookies}    //*[@id="gdpr-consent-notice"]
${locator_accept_cookies}    //*[@id="save"]
${locator_link_download}    //div[@class='col-lg-8']/table[13]/tbody/tr/td/p[2]/a
${locator_table}    //div[@class='col-lg-8']/table[14]

${dictable}    ''
${subtable}    ${dictable}
${subcount}    0
${groups}    ''

${username}    ''
${filename}    SampleData.zip
${timeout}    10s

*** Keywords ***
Start Suite
    Set Environment Variables
    Open Browser    about:blank    chrome
    Maximize Browser Window
    Go To    ${url}
    Wait Until Page Contains Element    ${locator_frame_cookies}
    Select Frame    ${locator_frame_cookies}
    Wait Until Element Is Visible    ${locator_accept_cookies}
    Click Button    ${locator_accept_cookies}
    Run Keyword And Ignore Error    Scroll Element Into View    ${locator_table}/tbody/tr

Start Test
    Run Keyword And Ignore Error    Scroll Element Into View    ${locator_table}
    Set Table

Finish Test
    Unset Table

Finish Suite
    Close Browser

# ********** TABLE OPERATIONS ********** #
Find Different Types of Items in the Column
    [Documentation]    Finds the different groups of items in the column and their quantity, and organizes the results for logging.
    [Arguments]    ${column}

    ${group_list}    Find Groups In Column    ${subtable.${column}}
    Insert Into List    ${group_list}    0    ${column}
    Set Global Variable    ${groups}    ${group_list}

Find Records with Maximum Value in Column
    [Documentation]    Finds records with the maximum value in the specified column of the table.
    [Arguments]    ${column}

    ${indexes}    Find List Element Indexes Of Maximum Value    ${subtable.${column}}
    Create SubTable And Set Globals    ${indexes}

Find Records Less than Value in Column
    [Documentation]    Finds records with less than the specified value in the specified column of the table.
    [Arguments]    ${column}    ${value}

    ${indexes}    Find List Element Indexes Of Less Than Value    ${subtable.${column}}    ${value}
    Create SubTable And Set Globals    ${indexes}

Find Specific Records in Column
    [Documentation]    Finds records equal to certain text in the specified column of the table.
    [Arguments]    ${column}    ${value}

    ${indexes}    Find List Element Indexes Of Equal Text    ${subtable.${column}}    ${value}
    Create SubTable And Set Globals    ${indexes}

Records in Condition Should be Exist
    [Documentation]    Validates that records that meet the specified condition exist.

    @{keys}    Get Dictionary Keys    ${subtable}
    ${first_key}    Set Variable    ${keys}[0]
    Should Not Be Empty    ${subtable.${first_key}}    There is no result in this condition.

# ********** FILE OPERATIONS ********** #
Click File Link
    [Documentation]    Clicks the file link to download.

    Click Link    ${locator_link_download}

Validate File Download
    [Documentation]    Validates that the file was downloaded within the given timeout.

    ${filepath}    Set Variable    C:\\Users\\${username}\\Downloads\\${filename}
    Wait Until File Exists    ${filepath}    timeout=${timeout}
    Should Exist    ${filepath}

# ********** TABLE (TEST DATA) CONFIGURATIONS ********** #
Set Table
    [Documentation]    If the global dictable variable is empty, it assigns a new table instance via the relevant keyword.
    # [Documentation]    Before operating on the table, the table must be set by calling this keyword.

    Run Keyword If    ${dictable} == ''    Get New Instance Of Table

Get New Instance of Table
    [Documentation]    Assigns a new table instance to the global dictable variable.

    ${table}    Transform WebTable To Dictionary    ${locator_table}
    Set Global Variable    ${dictable}    ${table}
    Set Global Variable    ${subtable}    ${dictable}

Unset Table
    [Documentation]    Empties the global dictable and subtable variables.

    Set Global Variable    ${dictable}    ''
    Set Global Variable    ${subtable}    ${dictable}

Create SubTable and Set Globals
    [Documentation]    Creates a sub table with given indexes and record results to global variables.
    [Arguments]    ${indexes}

    ${count}    Get Length    ${indexes}
    ${sub_dictable}    Create SubTable With Row Indexes    ${subtable}    ${indexes}
    Set Global Variable    ${subtable}    ${sub_dictable}
    Set Global Variable    ${subcount}    ${count}

# ********** ENVIRONMENT VARIABLES ********** #
Set Environment Variables
    [Documentation]    Include the required environment variables in the project.

    ${env_username}    Get Environment Variable    USERNAME
    Set Global Variable    ${username}    ${env_username}

# ********** LOGGERS ********** #
Log Groups
    [Documentation]    Creates logs of grouped items.

    Log Groups with Given List    ${groups}

Log Result
    [Documentation]    Creates a log of filtered table items based on the specified condition.

    Log Result Table as Dictionary    ${subtable}    ${subcount}
