# York-River-Bookseller-s-Database-SQL-Lab
SQL queries lab for IBM DB2 database

The script yrb_create.sql will create the YRB DB schema. It will also populate the tables with mock data. The script yrb_drop.sql is provided for convenience. It will drop your copy of YRB DB from your DB2 schema space. 

To create the YRB schema in your DB2 schema space:
% db2 -tf yrb_create.sql

To drop the YRB tables in your DB2 schema space:
% db2 -tf yrb_drop.sql

