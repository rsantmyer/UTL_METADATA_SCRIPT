CREATE OR REPLACE PACKAGE PKG_METADATA_SCRIPT AS
/******************************************************************************
   NAME:       PKG_METADATA_SCRIPT
   PURPOSE:  This package generates metadata scripts for maintaining data in tables.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        5/28/2017   Robert Santmyer  1. Created this package.
******************************************************************************/
   FUNCTION open_handle_f( ip_schema_name  IN VARCHAR2
                         , ip_table_name   IN VARCHAR2
                         , ip_db_link      IN VARCHAR2 )
     RETURN NUMBER;

   PROCEDURE add_filter_columns_p( ip_stmt_hndl          IN NUMBER 
                                 , ip_break_level        IN NUMBER
                                 , ip_column_01_value    IN VARCHAR2 DEFAULT NULL
                                 , ip_column_02_value    IN VARCHAR2 DEFAULT NULL );

   PROCEDURE close_handle( ip_stmt_hndl          IN NUMBER );
     
   PROCEDURE gen_meta_script_p( ip_stmt_hndl IN NUMBER );

   PROCEDURE gen_filter_meta_scripts_p( ip_stmt_hndl IN NUMBER );
   
   PROCEDURE gen_data_script_p( ip_stmt_hndl IN NUMBER );
   
END PKG_METADATA_SCRIPT;

/
