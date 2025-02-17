--What is Pragma Exception_Init?
--Associating a name for un-known exception

DECLARE
    myex EXCEPTION;
    PRAGMA EXCEPTION_INIT(myex,-20015); 
    n NUMBER := &n;
BEGIN
    FOR i IN 1..n LOOP
        dbms_output.put.line(i);
        IF i=n THEN
            RAISE myex;
        END IF;
    END LOOP;
EXCEPTION
    WHEN myex THEN
        dbms_output.put.line('loop finish');
END;
/
**********************************************

DECLARE
    v_num NUMBER;
    e_value_greater_than_limit EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_value_greater_than_limit, -01438);
BEGIN
    INSERT INTO exp
                (empno)
    VALUES     (77777777);

    v_num := 1 / 0;
EXCEPTION
    WHEN e_value_greater_than_limit THEN
      dbms_output.Put_line('**Pragma Exception_Init**');
END;

/ 
