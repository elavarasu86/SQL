--Varray
-- holds elements of same data type. Variable array. Elements can be access via index.

set serveroutput ON
DECLARE
    TYPE v_array_type IS varray(7) OF VARCHAR2(30);
    v_day V_ARRAY_TYPE := V_array_type(NULL);
-- have to initialize otherwise exception will pop up.
BEGIN
    V_day(1) := 'MONDAY';

    v_day.Extend();

    V_day(2) := 'TUESDAY';

    dbms_output.Put_line('v_day(1)'
                         ||V_day(1));
	dbms_output.Put_line(v_day.Limit);
	dbms_output.Put_line(v_day.Count);
	dbms_output.Put_line(v_day.First);
	dbms_output.Put_line(v_day.Last);
	dbms_output.Put_line(v_day.Trim);
	dbms_output.Put_line(v_day.Trim(2));
	dbms_output.Put_line(v_day.delete);
	dbms_output.Put_line(v_day.Extend);
	dbms_output.Put_line(v_day.Extend(2));
	dbms_output.Put_line(v_day.PRIOR(3));
	dbms_output.Put_line(v_day.NEXT(2));
END; 
/

----------------------------------------------
--Nested Table.
--Can hold n number of values.
--Will be able to delete an element.

DECLARE
TYPE V_NESTED_TAB_TYPE IS TABLE OF VARCHAR2(30);
V_DAY V_NESTED_TAB_TYPE := V_NESTED_TAB_TYPE(NULL,NULL,NULL);
BEGIN
V_day(1) := 'MONDAY';
V_day(2) := 'TUESDAY';
V_day(3) := 'WED';
    dbms_output.Put_line('v_day(1)'
                         ||V_day(1));
	dbms_output.Put_line(v_day.Limit);
	dbms_output.Put_line(v_day.Count);
	dbms_output.Put_line(v_day.First);
	dbms_output.Put_line(v_day.Last);
	dbms_output.Put_line(v_day.Trim(2));
	dbms_output.Put_line(v_day.delete);
		dbms_output.Put_line(v_day.delete(1));
	dbms_output.Put_line(v_day.Extend);
	dbms_output.Put_line(v_day.Extend(2));
	dbms_output.Put_line(v_day.PRIOR(3));
	dbms_output.Put_line(v_day.NEXT(2));
END;
/

----------------------------------------------
--Associative Array.
--Index path and value path is user defined. Index is not sequential number.
--Set of Key value pair.

DECLARE
TYPE V_ASSO_ARRAY_TYPE IS TABLE OF VARCHAR2(30) INDEX BY VARCHAR2(30);
V_COLOR_CODE V_ASSO_ARRAY_TYPE;
BEGIN
V_COLOR_CODE('WHITE'):='W';
V_COLOR_CODE('BLACK'):='B'
V_COLOR_CODE('BLUE'):='BL';
V_COLOR_CODE('RED'):='R';
DBMS_OUTPUT.Put_line(V_COLOR_CODE('BLUE'));
END;
/

----------------------------------------------
-- Multiset Operator.

1. MULTISET union
2. MULTISET INTERSECT
3. MULTISET EXCEPT


1:
declare 
type num_tab_type is table of number;
lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
lv_num_list3 num_tab_type;
BEGIN
lv_num_list3 := lv_num_list1 multiset union lv_num_list2;
for i in 1..lv_num_list3.count LOOP
dbms_output.Put_line(lv_num_list3(i));
end loop;
end;
/

2: 
declare 
type num_tab_type is table of number;
lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
lv_num_list3 num_tab_type;
BEGIN
lv_num_list3 := lv_num_list1 multiset union ALL lv_num_list2;
for i in 1..lv_num_list3.count LOOP
dbms_output.Put_line(lv_num_list3(i));
end loop;
end;
/

-- ABOVE TWO WORKS SAME.

declare 
type num_tab_type is table of number;
lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
lv_num_list3 num_tab_type;
BEGIN
lv_num_list3 := lv_num_list1 multiset union DISTINCT lv_num_list2;
for i in 1..lv_num_list3.count LOOP
dbms_output.Put_line(lv_num_list3(i));
end loop;
end;
/

-- WE CAN WRITE SAME WAY FOR OTHER TWO MULTISET OPERATOR.