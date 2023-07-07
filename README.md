# Contextures with Robot Framework

## About

This framework is built with Robot Framework and Selenium for UI testing of a web application's HTML table and file download link.

The framework is designed to be scalable so that new tests and functions can be easily added later.

## Prerequisites

Python must be installed on the system.

Then following libraries in Python must be installed:

* selenium
* robotframework
* robotframework-seleniumlibrary

To install:

`pip install selenium 4.9.0`

`pip install robotframework`

`pip install robotframework-seleniumlibrary`

> Note: Selenium 4.10 does not support robotframework yet.

## Usage

Test Cases in Test files can be run individually or in batches with clicking play icons in the IDE. Tests can also be run from the command line.

Sample run commands for terminal:

`robot -d results tests/Tests_WebTable.robot`

`robot -d results tests/Tests_DownloadFile.robot`

"results" is the folder you want to save the reports.
Execution automatically generates test reports.

## Flexible

Can add more filter conditions to test cases for narrowing down results. Code handles more than one filter conditions in a test case.

Can create new test cases with different filtering conditions on the table.

Can change existing test values and test for different output scale.

Can create new filtering methods in ProjectInterface using existing utility in different ways.

Can add more utility methods and increase the capabilities of the code.

## Structure

***resources/***

***resources/utility/***

These folders contains the files containing the auxiliary functions required for the tests.

The utility folder contains modules that perform general operations.

**ProjectInterface.robot**

This file contains the helper keywords that perform the project-specific operations required for the tests. It communicates with the files in the utility folder.

***tests/***

This folder contains test files with project-specific tests.
