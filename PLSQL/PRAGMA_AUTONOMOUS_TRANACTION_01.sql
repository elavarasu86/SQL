--What is PRAGMA autonomous_transaction: Its an independent transaction.

-- Lets take below scenario to understand what is PRAGMA autonomous_transaction.
--Scenario 1:

CREATE TABLE T(N NUMBER);
INSERT INTO T VALUES(1);
INSERT INTO T VALUES(2);
INSERT INTO T VALUES(3);
COMMIT;

--After commit all the transactions will be saved into database.
--Scenario 2:

CREATE TABLE T(N NUMBER);
INSERT INTO T VALUES(1);
INSERT INTO T VALUES(2);
INSERT INTO T VALUES(3);
ROLLBACK;

--After ROLLBACK all the transactions will be removed from database.
--Scenario 3:

CREATE TABLE T(N NUMBER);
SAVEPOINT A;
INSERT INTO T VALUES(1);
SAVEPOINT B;
INSERT INTO T VALUES(2);
SAVEPOINT C;
INSERT INTO T VALUES(3);
ROLLBACK TO SAVEPOINT B;
COMMIT;

--After ROLLBACK TO SAVEPOINT B, DB will remove transaction till point SAVEPOINT B, transaction before SAVEPOINT B will be available in DB.

--Scenario 4:

CREATE TABLE T(N NUMBER);
INSERT INTO T VALUES(1);--don't need to save
INSERT INTO T VALUES(2);--Need to store in DB
INSERT INTO T VALUES(3);--don't need to save

-- To achieve above scenario we have to do below things.

CREATE TABLE T(N NUMBER);

--Considered as Main transaction
INSERT INTO T VALUES(1);

--Considered as child/separate transaction. 
DECLARE
  PRAGMA autonomous_transaction; -- Keyword PRAGMA let's Oracle know this is separate/Child transaction
BEGIN
  INSERT INTO t VALUES
              (
                          2
              );
  
  COMMIT;-- Commit should be applied else transaction will fail.
END;
/

--Considered as Main transaction
INSERT INTO T VALUES(3);

ROLLBACK;
--After issuing rollback commant, only transaction 1 and transaction 2 will be rolled back not second transaction. By this way we can keep a transaction which is part of larger transactions that should not be rolled back.