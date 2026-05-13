--------------------------------------------------------------------------------
--test 1:
--no filtering
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--PASS
--------------------------------------------------------------------------------
--test 2:
--level 1 break, no filtering
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.add_filter_columns_p(1, 1);
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_filter_meta_scripts_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
    SELECT * FROM GT_METADATA_SCRIPT_FILTER_COL;
    SELECT * FROM GT_METADATA_SF_COL_VAL;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--PASS
--------------------------------------------------------------------------------
--test 3:
--level 1 break, level 1 filter
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.add_filter_columns_p(1, 1, :FILTER_COL1_VAL);
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_filter_meta_scripts_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
    SELECT * FROM GT_METADATA_SCRIPT_FILTER_COL;
    SELECT * FROM GT_METADATA_SF_COL_VAL;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--PASS
--------------------------------------------------------------------------------
--test 4:
--level 2 break, no filter
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.add_filter_columns_p(1, 2);
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_filter_meta_scripts_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
    SELECT * FROM GT_METADATA_SCRIPT_FILTER_COL;
    SELECT * FROM GT_METADATA_SF_COL_VAL;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--PASS
--------------------------------------------------------------------------------
--test 5:
--level 2 break, level 1 filter
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.add_filter_columns_p(1, 2, :FILTER_COL1_VAL);
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_filter_meta_scripts_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
    SELECT * FROM GT_METADATA_SCRIPT_FILTER_COL;
    SELECT * FROM GT_METADATA_SF_COL_VAL;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--FAIL
--------------------------------------------------------------------------------
--test 6:
--level 2 break, level 2 filter
DECLARE       v_stmt_handle NUMBER;    BEGIN      v_stmt_handle := PKG_METADATA_SCRIPT.open_handle_f(:TABLE_NAME);    END;
/
EXEC      PKG_METADATA_SCRIPT.add_filter_columns_p(1, 2, :FILTER_COL1_VAL, :FILTER_COL2_VAL);
EXEC      PKG_METADATA_SCRIPT.gen_meta_script_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_filter_meta_scripts_p(1);
EXEC      PKG_METADATA_SCRIPT.gen_data_script_p(1);
SELECT * FROM GT_METADATA_SCRIPT;
    SELECT * FROM GT_METADATA_SCRIPT_FILTER_COL;
    SELECT * FROM GT_METADATA_SF_COL_VAL;
EXEC      PKG_METADATA_SCRIPT.close_handle(1);
--PASS
--------------------------------------------------------------------------------
--test 7:
--split clobs
SELECT SCRIPT_NAME, FILTER_COLUMN_01_VALUE, cat.*
--, DATA_SCRIPT
  FROM GT_METADATA_SF_COL_VAL A
CROSS APPLY TABLE(APEX_STRING.SPLIT_CLOBS (p_str   => (A.DATA_SCRIPT)
                                                --  p_sep   IN VARCHAR2    DEFAULT apex_application.LF,
                                                --  p_limit IN PLS_INTEGER DEFAULT NULL 
                                                  )
            ) cat
 WHERE STATEMENT_HANDLE = 1
;
--PASS
--------------------------------------------------------------------------------
--test 8
SELECT *
FROM TABLE(PKG_METADATA_SCRIPT.get_metadata_script('APPLICATION') )
;
