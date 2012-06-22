kladr
=====

links
  pindx http://info.russianpost.ru/database/ops.html
  kladr http://www.gnivc.ru/inf_provision/classifiers_reference/kladr/
  

wget pindx
wget kladr

unzip

php dbf2mysql.php > {filename}.sql

import {filename}.sql

import alter.sql
import fixes.sql

php relation.php > relation.sql

import relation.sql

php doma.php > doma.sql

import doma.sql

import sphinx_view.sql

cp sphinx.conf /to/sphinxsearch/

indexer --all --rotate

php sphinx/test.php "query"
