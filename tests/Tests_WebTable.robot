*** Settings ***
Documentation    Tests on HTML Web Table
Resource  ../resources/ProjectInterface.robot

Suite Setup    Start Suite
Test Setup    Start Test
Test Teardown    Finish Test
Suite Teardown    Finish Suite

*** Test Cases ***
How Many Different Type of Items are in the Table
    [Tags]    regression    table
    When Find Different Types Of Items In The Column    Item
    Then Log Groups

Are There Records with Less than 5 Units
    [Tags]    filter    table
    When Find Records Less Than Value in Column    Units    5
    Then Records in Condition Should Be Exist
    And Log Result

Are There Pencil Records with Less than 5 Units
    [Tags]    filter    table
    When Find Records Less Than Value In Column    Units    5
    And Find Specific Records in Column    Item    Pencil
    Then Records in Condition Should Be Exist
    And Log Result

Find the Most Expensive Items
    [Tags]    regression    table
    When Find Records With Maximum Value In Column    UnitCost
    Then Log Result
