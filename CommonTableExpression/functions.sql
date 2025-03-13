-- The COALESCE() function returns the first non-null value in a list.

SELECT COALESCE(NULL,NULL,NULL,'elavarasu',NULL,'sql') from dual;
--elavarasu.
