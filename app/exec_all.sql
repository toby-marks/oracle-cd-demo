SET FEEDBACK OFF
SET VERIFY OFF
SET HEAD OFF
SET TERMOUT OFF

CONN / AS SYSDBA

COLUMN RUN_TIME NEW_VALUE RUN_TIME
COLUMN GLOBAL_NAME NEW_VALUE GLOBAL_NAME
COLUMN TD_FLAG NEW_VALUE 1

PROMPT

SELECT TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') AS run_time,
       global_name
  FROM global_name;

SELECT NULL TD_FLAG FROM DUAL WHERE 1=2;
SELECT NVL('&1','@@@') TD_FLAG FROM DUAL;

DEFINE TD_FLAG=&1

SPOOL exec_all.&run_time

SET TERMOUT ON
CLEAR SCREEN

PROMPT ################################################################################
SELECT ' INSTANCE: &global_name'||CHR(10)||' STARTING: '||
            TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS AM') FROM dual;
PROMPT ################################################################################

PROMPT 
PROMPT ================================================================================
PROMPT  THIS SCRIPT BUILDS THE DEMO APPLICATION.
PROMPT ================================================================================
PROMPT
PROMPT

PROMPT
PROMPT 
PROMPT ================================================================================
PROMPT  CONNECTED AS SYS
PROMPT ================================================================================
PROMPT

PROMPT
PROMPT 
PROMPT ================================================================================
PROMPT  SETTING UP...
PROMPT ================================================================================
@@./pre.sql
PROMPT DONE.

PROMPT
PROMPT 
PROMPT ================================================================================
PROMPT  BUILDING BOOKS TABLE...
PROMPT ================================================================================
@@./tables/books.sql
PROMPT DONE.

PROMPT
PROMPT 
PROMPT ================================================================================
PROMPT  BUILDING BOOKS API...
PROMPT ================================================================================
@@./packages/books_api.sql
PROMPT DONE.

@@do/if "'&TD_FLAG'='TEARDOWN'" 
    PROMPT
    PROMPT 
    PROMPT ================================================================================
    PROMPT  TEARING DOWN...
    PROMPT ================================================================================
    @./post.sql
    PROMPT DONE.
/* end_if */

PROMPT
PROMPT 
PROMPT ################################################################################
SELECT ' FINISHED: '||TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS AM') FROM dual;
PROMPT
PROMPT ################################################################################

SPOOL OFF

UNDEFINE TD_FLAG 1

SET HEAD ON
