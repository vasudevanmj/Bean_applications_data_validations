create or replace procedure xxits_cms_details_proc
as
    cursor  item   (P_COMPANY_ID in number)is
     select  COMPANY_ID ,ITEM_ID,VENDOR_NAME,EMAIL_VEN,PHONE_NUMBER_VEN,LOCATION_VEN,
              PAYMENT_MENTHOD   , MANUFACTURING_DATE,EXPIRY_DATE,QUANTITY,UNITY_PRICE
              AMOUNT,GST_V,TAXTABLE_AMT,GRAND_TOTAL,PAY_AMOUNT,UNITY_PRICE
     from      xxits_pms_master_t
     where  COMPANY_ID   =  P_COMPANY_ID
     and    COMPANY_ID   =  105;
     cursor comapny is         
    select  distinct COMPANY_ID,NAME_C,CATEGORY_TYPE,ADDRESS_LINE1,PHONE_NUMBER_COM,ADDRESS_LINE2,
            GST_COM,ORDER_NO,ORDER_DATE,EMAIL_COM
    from    xxits_pms_master_t
    where   COMPANY_ID   =  105;
begin   
                    dbms_output.put_line   ('<LIST_S_COMPANY_CODE>');
    for J   in   comapny
    loop
                    dbms_output.put_line   ('<G_COMPANY_CODE>');           
      dbms_output.put_line  ('<COMPANY_ID>'         ||j.COMPANY_ID          ||		'</COMPANY_ID> '); 					
      dbms_output.put_line  ('<NAME_C>'	            ||j.NAME_C	            ||		'</NAME_C>');	
      dbms_output.put_line  ('<CATEGORY_TYPE>'	    ||j.CATEGORY_TYPE	    ||		'</CATEGORY_TYPE>');					
      dbms_output.put_line  ('<ADDRESS_LINE1>'	    ||j.ADDRESS_LINE1	    ||		'</ADDRESS_LINE1>');					
      dbms_output.put_line  ('<ADDRESS_LINE2>'	    ||j.ADDRESS_LINE2	    ||		'</ADDRESS_LINE2>');
      dbms_output.put_line  ('<GST_COM>'		    ||j.GST_COM	            ||		'</GST_COM>');
      dbms_output.put_line  ('<PHONE_NUMBER_COM>'   ||j.PHONE_NUMBER_COM    ||		'</PHONE_NUMBER_COM>');
      dbms_output.put_line  ('<ORDER_NO>'		    ||j.ORDER_NO	        ||		'</ORDER_NO>');
      dbms_output.put_line  ('<ORDER_DATE>'		    ||j.ORDER_DATE	        ||		'</ORDER_DATE>');
      dbms_output.put_line  ('<EMAIL_COM>'		    ||j.EMAIL_COM	        ||		'</EMAIL_COM>');
                    dbms_output.put_line   ('</G_COMPANY_CODE>'); 
                    dbms_output.put_line   ('<LIST_S_ITEM_CODE>');
                    
           for i   in   item(j.COMPANY_ID )
           loop
           
                          dbms_output.put_line   ('<G_COMPANY_CODE>'); 
      dbms_output.put_line  ('<ITEM_ID>	'	        ||i.ITEM_ID	            ||		'</ITEM_ID>');
      dbms_output.put_line  ('<VENDOR_NAME>'	    ||i.VENDOR_NAME	        ||		'</VENDOR_NAME>');
      dbms_output.put_line  ('<EMAIL_VEN>'		    ||i.EMAIL_VEN	        ||		'</EMAIL_VEN>');
      dbms_output.put_line  ('<PHONE_NUMBER_VEN>'   ||i.PHONE_NUMBER_VEN	||		'</PHONE_NUMBER_VEN>');
      dbms_output.put_line  ('<LOCATION_VEN>'	    ||i.LOCATION_VEN	    ||		'</LOCATION_VEN>');
      dbms_output.put_line  ('<PAYMENT_MENTHOD>'    ||i.PAYMENT_MENTHOD	    ||		'</PAYMENT_MENTHOD>');
      dbms_output.put_line  ('<MANUFACTURING_DATE>'	||i.MANUFACTURING_DATE	||	    '</MANUFACTURING_DATE>');
      dbms_output.put_line  ('<EXPIRY_DATE>'		||i.EXPIRY_DATE	        ||	    '</EXPIRY_DATE>');
      dbms_output.put_line  ('<QUANTITY>'			||i.QUANTITY	        ||	    '</QUANTITY>');
      dbms_output.put_line  ('<UNITY_PRICE>'		||i.UNITY_PRICE	        ||	    '</UNITY_PRICE>');
      dbms_output.put_line  ('<AMOUNT>'				||i.AMOUNT	            || 	    '</AMOUNT>');
      dbms_output.put_line  ('<GST_V>'				||i.GST_V	            ||	    '</GST_V>');
      dbms_output.put_line  ('<TAXTABLE_AMT>'		||i.TAXTABLE_AMT	    ||	    '</TAXTABLE_AMT>');
      dbms_output.put_line  ('<GRAND_TOTAL>	'	||i.GRAND_TOTAL	        ||	    '</GRAND_TOTAL>');
      dbms_output.put_line  ('<PAY_AMOUNT>	'		||i.PAY_AMOUNT	        ||	    '</PAY_AMOUNT>');
                          dbms_output.put_line   ('</G_COMPANY_CODE>');
      end  loop;
                 dbms_output.put_line   ('</LIST_S_ITEM_CODE>');
      end   loop;
                   dbms_output.put_line   ('</LIST_S_COMPANY_CODE>');
end xxits_cms_details_proc;                   

set serveroutput  on
begin
xxits_cms_details_proc();
end;


