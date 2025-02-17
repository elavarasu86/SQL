--Write a query to print the given input string "Welcome" as given below output.

SELECT ROWNUM,
       Substr(s, ROWNUM, 1)      output1,
       Substr(s, ROWNUM *- 1, 1) output2,
       Substr(s, 1, ROWNUM)      output3,
       Substr(s, ROWNUM)         output4,
       Rpad(' ', ROWNUM, ' ')
       ||Substr(s, ROWNUM)       output5,
       Rpad(' ', Length(s) + 1 - ROWNUM, ' ')
       ||Substr(s, 1, ROWNUM)    output6
FROM   dual,
       (SELECT 'Welcome' s
        FROM   dual)
CONNECT BY LEVEL <= Length(s); 