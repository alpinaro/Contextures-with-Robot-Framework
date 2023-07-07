# Contextures with Robot Framework

## About

This framework is built with Robot Framework and Selenium for UI testing of a web application's HTML table and file download link.

The framework is designed to be scalable so that new tests and functions can be easily added later.

## Usage

Test Cases in Test files can be run individually or in batches with clicking play icons in the IDE. Tests can also be run from the command line.

Sample run commands for terminal:

robot -d results tests/Tests_WebTable.robot

robot -d results tests/Tests_DownloadFile.robot

"results" is the folder you want to save the reports.
Execution automatically generates test reports.

## Structure

***resources/***

***resources/utility/***

These folders contains the files containing the auxiliary functions required for the tests.

The utility folder contains modules that perform general operations.

**ProjectInterface.robot**

This file contains the helper keywords that perform the project-specific operations required for the tests. It communicates with the files in the utility folder.

***tests/***

This folder contains test files with project-specific tests.
