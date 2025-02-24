1. Error logging

--Example

CREATE TABLE T(C NUMBER);

SET serveroutput ON
BEGIN
    INSERT INTO t
    VALUES      (1);

    INSERT INTO t
    VALUES      ('100');

    INSERT INTO t
    VALUES      ('200$');

    INSERT INTO t
    VALUES      (5.32);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
END;

/ 
-- When executing above script we face exception and all the transaction will be rolled back.

CREATE TABLE ERROR_LOG(err_no NUMBER, err_msg VARCHAR2(100));

SET serveroutput ON
DECLARE
    lv_error_no  NUMBER;
    lv_error_msg VARCHAR2(100);
BEGIN
    INSERT INTO t
    VALUES      (1);

    INSERT INTO t
    VALUES      ('100');

    INSERT INTO t
    VALUES      ('200$');

    INSERT INTO t
    VALUES      (5.32);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      lv_error_no := SQLCODE;

      lv_error_msg := SQLERRM;

      INSERT INTO error_log
      VALUES     ( lv_error_no,
                  lv_error_msg);

      ROLLBACK;
END;

/ 

-- Even after above changes, if we face issue while inserting data, all the records will be rolled back, including error log table data.

-- To fix that change the script like below.

CREATE OR replace PROCEDURE Pr_log_error (p_err_no  NUMBER,
                                          p_err_msg VARCHAR2)
AS
  PRAGMA autonomous_transaction;
BEGIN
    INSERT INTO error_log
    VALUES     (p_err_no,
                p_err_msg);

    COMMIT;
END;

/ 


SET serveroutput ON
DECLARE
    lv_error_no  NUMBER;
    lv_error_msg VARCHAR2(100);
BEGIN
    INSERT INTO t
    VALUES      (1);

    INSERT INTO t
    VALUES      ('100');

    INSERT INTO t
    VALUES      ('200$');

    INSERT INTO t
    VALUES      (5.32);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      lv_error_no := SQLCODE;

      lv_error_msg := SQLERRM;
	  
	  Pr_log_error(p_err_no => lv_error_no,
				   p_err_msg => lv_error_msg);

      ROLLBACK;
END;

/ 

--After this change if a face any exception we will rollback all the transaction except error table transaction as this transaction is captured as part of child transaction.


2. Commint inside Trigger.

-- We cannot keep commit inside trigger, if we do we get "cannot commit in a trigger" exception.

CREATE TABLE T(C NUMBER);

CREATE OR REPLACE TRIGGER bf_ins_trig_t
BEFORE
	INSERT ON table
	FOR EACH ROW
BEGIN
	COMMIT;
END;
/

INSERT INTO T VALUES(1);
-- after this insert statement, trigger will be triggered and exception will pop up. To fix this.

CREATE OR REPLACE TRIGGER bf_ins_trig_t
BEFORE
	INSERT ON table
	FOR EACH ROW
DECLARE
	PRAGMA autonomous_transaction;
BEGIN
	COMMIT;
END;
/