SHOW VARIABLES;

SHOW SESSION VARIABLES;

SHOW GLOBAL VARIABLES;

SHOW VARIABLES LIKE '%auto%';


SELECT @@SESSION.autocommit;

SELECT @@GLOBAL.autocommit


SET autocommit = 0;

SET @@autocommit = 1;


SET GLOBAL autocommit = 0;

SET @@GLOBAL.autocommit = 1;









