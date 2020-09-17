/*  
    Author  : Nikhil Mishra
    Date    : 17.09.2020
    Desc    : CDSV View for KNA1 table
*/

@AbapCatalog.sqlViewName: 'ZDDLS_SIMPLE'   // Replace sql_view_name with any name
// for example ZDDLS_SIMPLE, this name can be used to check the view in SE11
// sqlViewName and CDS view name can be similar but it's better to keep it different
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Simple CDS View'
// Replace data_source_name with table name
define view ZCDSV_SIMPLE as select from kna1 {     
    key kunnr, 
        name1,
        ort01,
        land1
} 
  
  
 