#!/bin/bash

cd /work/sql
mysql -h $DB_PORT_3306_TCP_ADDR -u root < CreateDatabase.SQL
mysql -h $DB_PORT_3306_TCP_ADDR -u tdmind -p tdmind --password=tdmind < InitData.SQL

