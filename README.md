# Description
The repository contains a couple of useful SuiteQL queries that I have built while working on some NetSuite implementations.
Some SQL tables are pretty simple like Subsidiary.sql while others can create ready-to-use reports.

# Methodology 
To get the necessary knowledge and tools I used the following sources:
 - NetSuite documentation from Oracle.
 - Many Stack Overflow posts.
 - Blog N&S ERP Solution and post https://nserpsolutions.com/reporting/odbc/suiteql-odbc-query-to-retrieve-trial-balance-report/.
 - SuiteQL  Query Tool - "The SuiteQL Query Tool is a NetSuite native application that can be used to run SQL queries directly within a NetSuite instance".
   This app was a great help when I was testing queries and while looking for NS tables that according to Oracle documentation didn't exist.
   I learned about this tool on the blog of its developer https://timdietrich.me/. You read more about the app here https://timdietrich.me/netsuite-suitescripts/suiteql-query-tool/.

# Project Purpose 
In the repository, you can see only a fragment of my work. My goal was to enable loading NetSuite reports (queries in folder Reports) straight from DB to Excel file.
This way Financial Analysts will have immediate access to NetSuit data after opening the Excel file.
I have achieved this goal in the following steps:
1. Connecting NetSuite with Excel via ODBC connector.
2. Setting up a User Interface for selecting query parameters using VBA code in Excel.
3. Sending query to NetSuite via ODBC.
4. Data presentation in Excel tab.
Although I can't show here my VBA program which is crucial for the whole process I thought that describing it may inspire someone to try knowing that something like this is possible.

# Repository Structure
In the main folder, you can find some basic queries to NetSuite DB.

### Report folder
Contains the final queries that I have created for three financial reports all with data aggregated year to date:
- Trial Balance by Department
- Trial Balance by Entity closing balance
- Trial Balance by Entity opening balance

# Acknowlagements
Special thanks to Tim Dietrich and his blog https://timdietrich.me/

