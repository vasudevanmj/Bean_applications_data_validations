create or replace NONEDITIONABLE procedure xxdynamic_tables_header_line_proc 
as
    lt_master_po_table_t    varchar2(30)    := 'xxits_pms_master_t';
    its_cms_column_name_t   varchar2(40)    := 'xxits_cms_column_name_t';
    lt_header_table_t       varchar2(30)    := 'xxits_cms_header_t';
    lt_line_table_t         varchar2(30)    := 'xxits_cms_line_t';
    lt__validation_header_t varchar2(30)    := 'xxits_validation_header_t';
    lt_validation_line      varchar2(30)    := 'xxits_validation_line_t';
    lt_rejected_header      varchar2(30)    := 'xxits_rejected_header_t';
    lt_rejecte_line         varchar2(30)    := 'xxits_rejected_line';
    ld_delete_table_t       varchar2(30)    := 'xxits_pms_master_his_t';
    ls_store_table_t        varchar2(5000);

begin
    begin
    ls_store_table_t:=  'create table ' || lt_master_po_table_t || ' ('
                                        || 'company_id          number              ,    '
                                        || 'name_c              varchar2(200)       ,   '
                                        || 'category_type       varchar2(200)       ,   '
                                        || 'address_line1       varchar2(200)       ,   '
                                        || 'address_line2       varchar2(200)       ,   '
                                        || 'gst_com             varchar2(200)       ,   '
                                        || 'phone_number_com    varchar2(200)       ,   '
                                        || 'order_no            number              ,   '            
                                        || 'order_date          varchar2(40)        ,   '     
                                        || 'email_com           varchar2(200)       ,   '           
                                        ||'item_id              number              ,   '                
                                        ||'vendor_name          varchar2(50)        ,   '            
                                        ||'email_ven            varchar2(30)        ,   '                                         
                                        ||'phone_number_ven     number              ,   '
                                        ||'location_ven         varchar2(50)        ,   '
                                        ||'payment_menthod      varchar2(50)        ,   '
                                        ||'manufacturing_date   varchar2(50)        ,   '   
                                        ||'expiry_date          varchar2(50)        ,   '
                                        ||'item                 varchar2(100)       ,   '
                                        ||'quantity             number              ,   '
                                        ||'unity_price          number              ,   '
                                        ||'amount               number              ,   '
                                        ||'gst_v                number              ,   '
                                        ||'taxtable_amt         number              ,   '
                                        ||'grand_total          number              ,   '
                                        ||'pay_amount           number              ,   '
                                        ||'error_flag           varchar2(600)default ''n'' ,   '
                                        ||'error_msg            varchar2(600)        ,   '
                                        || 'attribute_category  varchar2(240)       ,   '
                                        || 'attribute1          varchar2(240)       ,   '
                                        || 'attribute2          varchar2(240)       ,   '
                                        || 'attribute3          varchar2(240)       ,   '
                                        || 'attribute4          varchar2(240)       ,   '
                                        || 'attribute5          varchar2(240)       ,   '
                                        || 'attribute6          varchar2(240)       ,   '
                                        || 'attribute7          varchar2(240)       ,   '
                                        || 'attribute8          varchar2(240)       ,   '
                                        || 'attribute9          varchar2(240)       ,   '
                                        || 'attribute10         varchar2(240)       ,   '
                                        || 'attribute11         varchar2(240)       ,   '
                                        || 'attribute12         varchar2(240)       ,   '         
                                        || 'attribute13         varchar2(240)       ,   '                          
                                        || 'attribute14         varchar2(240)       ,   '      
                                        || 'attribute15         varchar2(240)       ,   '       
                                        || 'creation_date       date                ,   ' 
                                        || 'created_by          number              ,   '
                                        || 'last_update_date    date                ,   '
                                        || 'last_update_by      number              ,   '
                                        || 'last_update_login   number                  '
                                        || ')';
           execute immediate ls_store_table_t; 
    exception
        when others then
        dbms_output.put_line('header main exeption---------->' || sqlerrm);        
    end;
    begin
    ls_store_table_t:=  'create table ' || its_cms_column_name_t || ' ('
                                        || 'column_name          varchar2(300), '
                                        || 'column_data_type     varchar2(300), '
                                        || 'column_size          varchar2(300)  '
                                        || ')';
           execute immediate ls_store_table_t; 
    exception
        when others then
        dbms_output.put_line('column_name exeption---------->' || sqlerrm);        
    end;
    begin
        ls_store_table_t := 'create table ' || lt_header_table_t || ' (    '
                             || 'company_id          number             ,   '
                             || 'name_c              varchar2(200)      ,   '
                             || 'category_type       varchar2(200)      ,   '
                             || 'address_line1       varchar2(200)      ,   '
                             || 'address_line2       varchar2(200)      ,   '
                             || 'gst_com             varchar2(200)      ,   '
                             || 'phone_number_com    varchar2(200)      ,   '
                             || 'order_no            number             ,   '
                             || 'order_date          varchar2(200)      ,   '
                             || 'email_com           varchar2(200)      ,   '
                             || 'attribute_category  varchar2(240)      ,   '
                             || 'attribute1          varchar2(240)      ,   '
                             || 'attribute2          varchar2(240)      ,   '
                             || 'attribute3          varchar2(240)      ,   '
                             || 'attribute4          varchar2(240)      ,   '
                             || 'attribute5          varchar2(240)      ,   '
                             || 'attribute6          varchar2(240)      ,   '
                             || 'attribute7          varchar2(240)      ,   '
                             || 'attribute8          varchar2(240)      ,   '
                             || 'attribute9          varchar2(240)      ,   '
                             || 'attribute10         varchar2(240)      ,   '
                             || 'attribute11         varchar2(240)      ,   '
                             || 'attribute12         varchar2(240)      ,   '
                             || 'attribute13         varchar2(240)      ,   '
                             || 'attribute14         varchar2(240)      ,   '
                             || 'attribute15         varchar2(240)      ,   '
                             || 'creation_date       date               ,   '
                             || 'created_by          number             ,   '
                             || 'last_update_date    date               ,   '
                             || 'last_update_by      number             ,   '
                             || 'last_update_login   number'
                             || ')';
           execute immediate ls_store_table_t;                     
        exception
            when others then
                dbms_output.put_line('header main exeption---------->' || sqlerrm); 
    end;
      begin
        ls_store_table_t := 'create table ' || lt_line_table_t || ' (    '
                           || 'company_id          number          ,    '
                           || 'item_id             number          ,    '
                           || 'vendor_name         varchar2(200)   ,    '
                           || 'email_ven           varchar2(200)   ,    '
                           || 'phone_number_ven    number          ,    '
                           || 'location_ven        varchar2(200)   ,    '
                           || 'payment_menthod     varchar2(200)   ,    '
                           || 'manufacturing_date  varchar2(200)   ,    '
                           || 'expiry_date         varchar2(200)   ,    '
                           || 'item                varchar2(200)   ,    '
                           || 'quantity            number          ,    '
                           || 'unity_price         number          ,    '
                           || 'amount              number          ,    '
                           || 'gst_v               number          ,    '
                           || 'taxtable_amt        number          ,    '
                           || 'grand_total         number          ,    '
                           || 'pay_amount          number          ,    '
                           || 'attribute_category  varchar2(240)   ,    '
                           || 'attribute1          varchar2(240)   ,    '
                           || 'attribute2          varchar2(240)   ,    '
                           || 'attribute3          varchar2(240)   ,    '
                           || 'attribute4          varchar2(240)   ,    '
                           || 'attribute5          varchar2(240)   ,    '
                           || 'attribute6          varchar2(240)   ,    '
                           || 'attribute7          varchar2(240)   ,    '
                           || 'attribute8          varchar2(240)   ,    '
                           || 'attribute9          varchar2(240)   ,    '
                           || 'attribute10         varchar2(240)   ,    '
                           || 'attribute11         varchar2(240)   ,    '
                           || 'attribute12         varchar2(240)   ,    '
                           || 'attribute13         varchar2(240)   ,    '
                           || 'attribute14         varchar2(240)   ,    '
                           || 'attribute15         varchar2(240)   ,    '
                           || 'creation_date       date            ,    '
                           || 'created_by          number          ,    '
                           || 'last_update_date    date            ,    '
                           || 'last_update_by      number          ,    '
                           || 'last_update_login   number'
                           || ')';
           execute immediate ls_store_table_t;                   
        exception
            when others then
                dbms_output.put_line('line table main------>' || sqlerrm); 
    end;
    begin
    ls_store_table_t := 'create table ' || lt__validation_header_t || ' ('
                             || 'company_id          number             ,   '
                             || 'name_c              varchar2(200)      ,   '
                             || 'category_type       varchar2(200)      ,   '
                             || 'address_line1       varchar2(200)      ,   '
                             || 'address_line2       varchar2(200)      ,   '
                             || 'gst_com             varchar2(200)      ,   '
                             || 'phone_number_com    varchar2(200)      ,   '
                             || 'order_no            number             ,   '
                             || 'order_date          varchar2(200)      ,   '
                             || 'email_com           varchar2(200)      ,   '
                             || 'attribute_category  varchar2(240)      ,   '
                             || 'attribute1          varchar2(240)      ,   '
                             || 'attribute2          varchar2(240)      ,   '
                             || 'attribute3          varchar2(240)      ,   '
                             || 'attribute4          varchar2(240)      ,   '
                             || 'attribute5          varchar2(240)      ,   '
                             || 'attribute6          varchar2(240)      ,   '
                             || 'attribute7          varchar2(240)      ,   '
                             || 'attribute8          varchar2(240)      ,   '
                             || 'attribute9          varchar2(240)      ,   '
                             || 'attribute10         varchar2(240)      ,   '
                             || 'attribute11         varchar2(240)      ,   '
                             || 'attribute12         varchar2(240)      ,   '
                             || 'attribute13         varchar2(240)      ,   '
                             || 'attribute14         varchar2(240)      ,   '
                             || 'attribute15         varchar2(240)      ,   '
                             || 'creation_date       date               ,   '
                             || 'created_by          number             ,   '
                             || 'last_update_date    date               ,   '
                             || 'last_update_by      number             ,   '
                             || 'last_update_login   number'
                             || ')';
        exception
            when others then
                dbms_output.put_line( 'validation header main execption--------->'|| sqlerrm);
       execute immediate ls_store_table_t;            
    end;
    begin
    ls_store_table_t := 'create table ' || lt_rejected_header || ' ('
                             || 'company_id          number             ,   '
                             || 'name_c              varchar2(200)      ,   '
                             || 'category_type       varchar2(200)      ,   '  
                             || 'address_line1       varchar2(200)      ,   '
                             || 'address_line2       varchar2(200)      ,   '
                             || 'gst_com             varchar2(200)      ,   '  
                             || 'phone_number_com    varchar2(200)      ,   '
                             || 'order_no            number             ,   '
                             || 'order_date          varchar2(200)      ,   '
                             || 'email_com           varchar2(200)      ,   '
                             || 'attribute_category  varchar2(240)      ,   '
                             || 'attribute1          varchar2(240)      ,   '
                             || 'attribute2          varchar2(240)      ,   '
                             || 'attribute3          varchar2(240)      ,   '
                             || 'attribute4          varchar2(240)      ,   '
                             || 'attribute5          varchar2(240)      ,   '
                             || 'attribute6          varchar2(240)      ,   '
                             || 'attribute7          varchar2(240)      ,   '
                             || 'attribute8          varchar2(240)      ,   '
                             || 'attribute9          varchar2(240)      ,   '
                             || 'attribute10         varchar2(240)      ,   '
                             || 'attribute11         varchar2(240)      ,   '
                             || 'attribute12         varchar2(240)      ,   '
                             || 'attribute13         varchar2(240)      ,   '
                             || 'attribute14         varchar2(240)      ,   '
                             || 'attribute15         varchar2(240)      ,   '
                             || 'creation_date       date               ,   '
                             || 'created_by          number             ,   '
                             || 'last_update_date    date               ,   '
                             || 'last_update_by      number             ,   '
                             || 'last_update_login   number'
                             || ')';
        execute immediate ls_store_table_t;                     
        exception
            when others then
                dbms_output.put_line( 'rejected header main execption-------->' || sqlerrm); 
    end;
    begin
        ls_store_table_t := 'create table ' || lt_validation_line || ' (    '
                           || 'company_id          number          ,    '
                           || 'item_id             number          ,    '
                           || 'vendor_name         varchar2(200)   ,    '
                           || 'email_ven           varchar2(200)   ,    '
                           || 'phone_number_ven    number          ,    '
                           || 'location_ven        varchar2(200)   ,    '
                           || 'payment_menthod     varchar2(200)   ,    '
                           || 'manufacturing_date  varchar2(200)   ,    '
                           || 'expiry_date         varchar2(200)   ,    '
                           || 'item                varchar2(200)   ,    '
                           || 'quantity            number          ,    '
                           || 'unity_price         number          ,    '
                           || 'amount              number          ,    '
                           || 'gst_v               number          ,    '
                           || 'taxtable_amt        number          ,    '
                           || 'grand_total         number          ,    '
                           || 'pay_amount          number          ,    '
                           || 'attribute_category  varchar2(240)   ,    '
                           || 'attribute1          varchar2(240)   ,    '
                           || 'attribute2          varchar2(240)   ,    '
                           || 'attribute3          varchar2(240)   ,    '
                           || 'attribute4          varchar2(240)   ,    '
                           || 'attribute5          varchar2(240)   ,    '
                           || 'attribute6          varchar2(240)   ,    '
                           || 'attribute7          varchar2(240)   ,    '
                           || 'attribute8          varchar2(240)   ,    '
                           || 'attribute9          varchar2(240)   ,    '
                           || 'attribute10         varchar2(240)   ,    '
                           || 'attribute11         varchar2(240)   ,    '
                           || 'attribute12         varchar2(240)   ,    '
                           || 'attribute13         varchar2(240)   ,    '
                           || 'attribute14         varchar2(240)   ,    '
                           || 'attribute15         varchar2(240)   ,    '
                           || 'creation_date       date            ,    '
                           || 'created_by          number          ,    '
                           || 'last_update_date    date            ,    '
                           || 'last_update_by      number          ,    '
                           || 'last_update_login   number'
                           || ')';
           execute immediate ls_store_table_t;                   
        exception
            when others then
                dbms_output.put_line('      validation  line    main  execption--------->'|| sqlerrm); 
    end;
    begin
        ls_store_table_t := 'create table ' || lt_rejecte_line || ' (    '
                           || 'company_id          number          ,    '
                           || 'item_id             number          ,    '
                           || 'vendor_name         varchar2(200)   ,    '
                           || 'email_ven           varchar2(200)   ,    '
                           || 'phone_number_ven    number          ,    '
                           || 'location_ven        varchar2(200)   ,    '
                           || 'payment_menthod     varchar2(200)   ,    '
                           || 'manufacturing_date  varchar2(200)   ,    '
                           || 'expiry_date         varchar2(200)   ,    '
                           || 'item                varchar2(200)   ,    '
                           || 'quantity            number          ,    '
                           || 'unity_price         number          ,    '
                           || 'amount              number          ,    '
                           || 'gst_v               number          ,    '
                           || 'taxtable_amt        number          ,    '
                           || 'grand_total         number          ,    '
                           || 'pay_amount          number          ,    '
                           || 'attribute_category  varchar2(240)   ,    '
                           || 'attribute1          varchar2(240)   ,    '
                           || 'attribute2          varchar2(240)   ,    '
                           || 'attribute3          varchar2(240)   ,    '
                           || 'attribute4          varchar2(240)   ,    '
                           || 'attribute5          varchar2(240)   ,    '
                           || 'attribute6          varchar2(240)   ,    '
                           || 'attribute7          varchar2(240)   ,    '
                           || 'attribute8          varchar2(240)   ,    '
                           || 'attribute9          varchar2(240)   ,    '
                           || 'attribute10         varchar2(240)   ,    '
                           || 'attribute11         varchar2(240)   ,    '
                           || 'attribute12         varchar2(240)   ,    '
                           || 'attribute13         varchar2(240)   ,    '
                           || 'attribute14         varchar2(240)   ,    '
                           || 'attribute15         varchar2(240)   ,    '
                           || 'creation_date       date            ,    '
                           || 'created_by          number          ,    '
                           || 'last_update_date    date            ,    '
                           || 'last_update_by      number          ,    '
                           || 'last_update_login   number'
                           || ')';
                           dbms_output.put_line('table  create');
           execute immediate ls_store_table_t;                   
        exception
            when others then
                dbms_output.put_line('  rejecte line main exception--------->' || sqlerrm); 
    begin
						ls_store_table_t:=  'create table '	|| ld_delete_table_t || ' ('
                                        || 'company_id          number              ,    '
                                        || 'name_c              varchar2(200)       ,   '
                                        || 'category_type       varchar2(200)       ,   '
                                        || 'address_line1       varchar2(200)       ,   '
                                        || 'address_line2       varchar2(200)       ,   '
                                        || 'gst_com             varchar2(200)       ,   '
                                        || 'phone_number_com    varchar2(200)       ,   '
                                        || 'order_no            number              ,   '            
                                        || 'order_date          varchar2(40)        ,   '     
                                        || 'email_com           varchar2(200)       ,   '           
                                        ||'item_id              number              ,   '                
                                        ||'vendor_name          varchar2(50)        ,   '            
                                        ||'email_ven            varchar2(30)        ,   '                                         
                                        ||'phone_number_ven     number              ,   '
                                        ||'location_ven         varchar2(50)        ,   '
                                        ||'payment_menthod      varchar2(50)        ,   '
                                        ||'manufacturing_date   varchar2(50)        ,   '   
                                        ||'expiry_date          varchar2(50)        ,   '
                                        ||'item                 varchar2(100)       ,   '
                                        ||'quantity             number              ,   '
                                        ||'unity_price          number              ,   '
                                        ||'amount               number              ,   '
                                        ||'gst_v                number              ,   '
                                        ||'taxtable_amt         number              ,   '
                                        ||'grand_total          number              ,   '
                                        ||'pay_amount           number              ,   '
                                        ||'error_flag           varchar2(600)default ''n'' ,   '
                                        ||'error_msg            varchar2(600)        ,   '
                                        || 'attribute_category  varchar2(240)       ,   '
                                        || 'attribute1          varchar2(240)       ,   '
                                        || 'attribute2          varchar2(240)       ,   '
                                        || 'attribute3          varchar2(240)       ,   '
                                        || 'attribute4          varchar2(240)       ,   '
                                        || 'attribute5          varchar2(240)       ,   '
                                        || 'attribute6          varchar2(240)       ,   '
                                        || 'attribute7          varchar2(240)       ,   '
                                        || 'attribute8          varchar2(240)       ,   '
                                        || 'attribute9          varchar2(240)       ,   '
                                        || 'attribute10         varchar2(240)       ,   '
                                        || 'attribute11         varchar2(240)       ,   '
                                        || 'attribute12         varchar2(240)       ,   '         
                                        || 'attribute13         varchar2(240)       ,   '                          
                                        || 'attribute14         varchar2(240)       ,   '      
                                        || 'attribute15         varchar2(240)       ,   '       
                                        || 'creation_date       date                ,   ' 
                                        || 'created_by          number              ,   '
                                        || 'last_update_date    date                ,   '
                                        || 'last_update_by      number              ,   '
                                        || 'last_update_login   number                  '
                                        || ')';
           execute immediate ls_store_table_t; 
    exception
        when others then
        dbms_output.put_line('header main exeption---------->' || sqlerrm);        
    end;            
    end;
     exception
            when others then
                dbms_output.put_line('  rejecte line main exception--------->' || sqlerrm); 

end xxdynamic_tables_header_line_proc;