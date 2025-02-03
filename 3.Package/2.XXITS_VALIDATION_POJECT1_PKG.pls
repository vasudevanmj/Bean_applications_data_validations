create or replace NONEDITIONABLE package body    xxits_validation_poject1_pkg
as 
--<<<<<<<<< start  eamil_function>>>>>>>>>>>>>>---
    function  xxits_validation_email_duplicate(p_email_d in  varchar2)  
    return  varchar2
    as
        lc_count     varchar2(40);
    begin
        select  count(*)
        into    lc_count
        from    xxits_pms_master_t
        where   email_ven   = p_email_d;

        if lc_count >1 then
            return 'no';
        else
            return 'yes';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);
    end xxits_validation_email_duplicate ;
-------------------------------------------------------------------------------------
    function  xxit_validation_email_formate   (p_email_id   in varchar2)
    return  varchar2
    as
    begin
        if   p_email_id   like  '%@%.com' then
            return  'yes';
        else    
            return  'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxit_validation_email_formate  ;
--<<<<<<<<<end  eamil_function>>>>>>>>>>>>>>---

--<<<<<<<<start phone   number      function>>>>--
    function  xxits_validation_phone_formate(p_phone_number   in number)
    return  varchar2
    as
    begin
        if  length (p_phone_number)=10   then
            return  'yes';
        else    
            return  'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxits_validation_phone_formate  ;

------------------------------------------------------------------
    function    xxits_validation_phone_duplicate(p_phone    in  number)
    return  varchar2
    as
        lc_count    number;
    begin
        select   count(*)  
        into    lc_count    
        from    xxits_pms_master_t
        where   phone_number_ven    = p_phone;
        if  lc_count>1  then
            return  'no';
        else    
            return    'yes';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxits_validation_phone_duplicate;
--<<<<<<<<end  phone   number      function>>>>--

--<<<start  gst number  >>>>>>>>>>---------

    function  xxits_gst_validation(P_gst in varchar )
    return  varchar2
    as
    begin
        if length (P_gst) =15  then
            return  'yes';
        else
            return  'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxits_gst_validation;
--<<<   end start  gst number  >>>>>>>>>>---------
----<<<<    start   payment menthod>>>>>------
    function  xxit_validation_payment_formate   (p_paymnet   in varchar2)
    return  varchar2
    as
    begin
        if   p_paymnet   like  'cash'   or p_paymnet like   'credit'   or p_paymnet    like  'debit'    then
            return  'yes';
        else    
            return  'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxit_validation_payment_formate  ;
----<<<<    end   payment menthod>>>>>------

---<<<<<  start  pay the amount>>>>>>>>>>>>-----
    function xxit_validation_payment_balance_formate(P_item in  varchar2) 
    return  varchar2
    as
        ln_payment          number;
        ln_paythe_amount    number;
    begin
        select  grand_total,pay_amount
        into    ln_payment,ln_paythe_amount
        from    xxits_pms_master_t
        where   item_id     =   P_item;
        if    ln_payment   = ln_paythe_amount   then
            return  'yes';
        else
            return   'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end xxit_validation_payment_balance_formate;  

    procedure xxits_validation_master_t
as

    lc_email_id                 varchar2(40);
    lc_return_e_v               varchar2(10);
    lc_reture_e_d               varchar(10);
    lc_phone_number             number;
    lc_return_p_v               varchar2(10);
    lc_return_p_d               varchar2(10);
    lm_message_error            varchar2(1000);
    lm_message_flag             varchar2(1000);
    lc_item_id                  number;
    lc_return_pay               varchar2(10);
    lc_return_formate_menthod   varchar2(10);
    lc_payment_menthod          varchar2(40);
    lc_return_manufactur_date   varchar2(40);


    cursor email is
    select email_ven,item_id   ,phone_number_ven,payment_menthod
    from   xxits_pms_master_t; 
begin
    for i  in email 
    loop
    lm_message_error            :=  null;
    lm_message_flag             :=  null;
    lc_email_id                 :=  i.email_ven; 
    lc_return_e_v               :=  xxit_validation_email_formate(lc_email_id);
    lc_reture_e_d               :=  xxits_validation_email_duplicate(lc_email_id);
    lc_phone_number             :=  i.phone_number_ven;
    lc_return_p_v               :=  xxits_validation_phone_formate(lc_phone_number);
    lc_return_p_d               :=  xxits_validation_phone_duplicate(lc_phone_number);
    lc_item_id                  :=  i.item_id;  
    lc_return_pay               :=  xxit_validation_payment_balance_formate(lc_item_id);
    lc_payment_menthod          :=  i.payment_menthod;
    lc_return_formate_menthod   :=  xxit_validation_payment_formate(lc_payment_menthod);
    lc_return_manufactur_date   :=  xxit_date_null_values(lc_item_id);

    if  lc_return_e_v  ='yes'then
        dbms_output.put_line(   'valid email');
    else
        lm_message_error    :=  'invalid email';
        lm_message_flag     :=  'e';
		
    end if;
	
    if  lc_reture_e_d   =   'yes'then
        dbms_output.put_line(   'valid email');
    else
        lm_message_error    :=lm_message_error||''||  'duplicate    email_id records ';
        lm_message_flag     :=  'e';
    end if;
	
    if  lc_return_p_v   =   'yes'then
            dbms_output.put_line(   'valid phone  number');
    else 
        lm_message_error    :=lm_message_error||''||  'invalid phone  number';
        lm_message_flag     :=  'e';
    end if;
	
    if  lc_return_p_d   =   'yes'then
            dbms_output.put_line(   'valid phone  number');
    else  
        lm_message_error    :=lm_message_error||''||  'duplicate    phone   numher records';
        lm_message_flag     :=  'e';
    end if;
	
    if  lc_return_pay   =   'yes'then
            dbms_output.put_line(   'successful done ');
    else    
        lm_message_error    :=lm_message_error||''||  'pay the due amount' ;
        lm_message_flag     :=  'e';
    end if;
	
    if  lc_return_formate_menthod   =   'yes'then
        dbms_output.put_line(   'payment  method    is  correct');
    else 
        lm_message_error    :=lm_message_error||''||  'wrong the payment method' ;
        lm_message_flag     :=  'e';
    end if;
	
    if  lc_return_manufactur_date   =   'yes'then
        dbms_output.put_line(   ' correct values  ');
    else   
        lm_message_error    :=lm_message_error||''|| 'manufacturing date not mention'      ;
    end if;  
	
        lm_message_flag     :=  'e';
    if  lc_return_e_v   =   'yes'  and  lc_reture_e_d = 'yes'   and lc_return_p_v   ='yes'  and lc_return_p_d  ='yes'
        and lc_return_pay='yes' and     lc_return_formate_menthod  ='yes'and    lc_return_manufactur_date   ='yes'then
        lm_message_error    :=lm_message_error||''||  'all the record is correct' ;
        lm_message_flag     :=  'v';
    end if;
	
    
    update  xxits_pms_master_t
    set     error_flag   =   lm_message_flag,
            error_msg   =   lm_message_error
    where   item_id      =   i.item_id;
    
    commit;
    end loop;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);
end xxits_validation_master_t;
     procedure xxits_cms_details_reports
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
     exception
        when  others    then
        dbms_output.put_line(sqlerrm);              
end xxits_cms_details_reports;
    procedure xxits_pms_xml_proc(p_ERROR_FLAG  in  varchar2)
as
    
    cursor  item   (P_COMPANY_ID in number)is
    select      COMPANY_ID ,ITEM_ID,VENDOR_NAME,EMAIL_VEN,PHONE_NUMBER_VEN,LOCATION_VEN,
                PAYMENT_MENTHOD   , MANUFACTURING_DATE,EXPIRY_DATE,QUANTITY,UNITY_PRICE
                AMOUNT,GST_V,TAXTABLE_AMT,GRAND_TOTAL,PAY_AMOUNT,UNITY_PRICE,ERROR_FLAG
    from      xxits_pms_master_t
    where  COMPANY_ID   =  P_COMPANY_ID
    and  upper  (ERROR_FLAG )  = upper( p_ERROR_FLAG);
    cursor comapny is         
    select  distinct COMPANY_ID,NAME_C,CATEGORY_TYPE,ADDRESS_LINE1,PHONE_NUMBER_COM,ADDRESS_LINE2,
                        GST_COM,ORDER_NO,ORDER_DATE,EMAIL_COM
        from    xxits_pms_master_t;
    lc_file_handle UTL_FILE.FILE_TYPE;    
    lc_file_name     varchar2(500)   :='ITS'||'_'||p_ERROR_FLAG||'BEAN'||to_date(sysdate,'DD-MON-YYYY')||000||its_xml_seq.nextval||'.xml';
    lc_directory     varchar2(300)   :='MINI_PROJECT';        
begin
    lc_file_handle := UTL_FILE.FOPEN(lc_directory, lc_file_name, 'W');
    
    UTL_FILE.PUT_LINE(lc_file_handle, '<?xml version="1.0" encoding="UTF-8"?>');  
                          UTL_FILE.PUT_LINE(lc_file_handle,'<LIST_S_COMPANY_CODE>');
    for J   in   comapny
    loop
                    UTL_FILE.put_line   (lc_file_handle,'<G_COMPANY_CODE>');           
      UTL_FILE.put_line  (lc_file_handle,'<COMPANY_ID>'         ||j.COMPANY_ID          ||		'</COMPANY_ID> '); 					
      UTL_FILE.put_line  (lc_file_handle,'<NAME_C>'	            ||j.NAME_C	            ||		'</NAME_C>');	
      UTL_FILE.put_line  (lc_file_handle,'<CATEGORY_TYPE>'	    ||j.CATEGORY_TYPE	    ||		'</CATEGORY_TYPE>');					
      UTL_FILE.put_line  (lc_file_handle,'<ADDRESS_LINE1>'	    ||j.ADDRESS_LINE1	    ||		'</ADDRESS_LINE1>');					
      UTL_FILE.put_line  (lc_file_handle,'<ADDRESS_LINE2>'	    ||j.ADDRESS_LINE2	    ||		'</ADDRESS_LINE2>');
      UTL_FILE.put_line  (lc_file_handle,'<GST_COM>'		    ||j.GST_COM	            ||		'</GST_COM>');
      UTL_FILE.put_line  (lc_file_handle,'<PHONE_NUMBER_COM>'   ||j.PHONE_NUMBER_COM    ||		'</PHONE_NUMBER_COM>');
      UTL_FILE.put_line  (lc_file_handle,'<ORDER_NO>'		    ||j.ORDER_NO	        ||		'</ORDER_NO>');
      UTL_FILE.put_line  (lc_file_handle,'<ORDER_DATE>'		    ||j.ORDER_DATE	        ||		'</ORDER_DATE>');
      UTL_FILE.put_line  (lc_file_handle,'<EMAIL_COM>'		    ||j.EMAIL_COM	        ||		'</EMAIL_COM>');
                    UTL_FILE.put_line   (lc_file_handle,'</G_COMPANY_CODE>'); 
                    UTL_FILE.put_line   (lc_file_handle,'<LIST_S_ITEM_CODE>');
                    
           for i   in   item(j.COMPANY_ID )
           loop
           
                          UTL_FILE.put_line   (lc_file_handle,'<G_COMPANY_CODE>'); 
      UTL_FILE.put_line  (lc_file_handle,'<ITEM_ID>	'	        ||i.ITEM_ID	            ||		'</ITEM_ID>');
      UTL_FILE.put_line  (lc_file_handle,'<VENDOR_NAME>'	    ||i.VENDOR_NAME	        ||		'</VENDOR_NAME>');
      UTL_FILE.put_line  (lc_file_handle,'<EMAIL_VEN>'		    ||i.EMAIL_VEN	        ||		'</EMAIL_VEN>');
      UTL_FILE.put_line  (lc_file_handle,'<PHONE_NUMBER_VEN>'   ||i.PHONE_NUMBER_VEN	||		'</PHONE_NUMBER_VEN>');
      UTL_FILE.put_line  (lc_file_handle,'<LOCATION_VEN>'	    ||i.LOCATION_VEN	    ||		'</LOCATION_VEN>');
      UTL_FILE.put_line  (lc_file_handle,'<PAYMENT_MENTHOD>'    ||i.PAYMENT_MENTHOD	    ||		'</PAYMENT_MENTHOD>');
      UTL_FILE.put_line  (lc_file_handle,'<MANUFACTURING_DATE>'	||i.MANUFACTURING_DATE	||	    '</MANUFACTURING_DATE>');
      UTL_FILE.put_line  (lc_file_handle,'<EXPIRY_DATE>'		||i.EXPIRY_DATE	        ||	    '</EXPIRY_DATE>');
      UTL_FILE.put_line  (lc_file_handle,'<QUANTITY>'			||i.QUANTITY	        ||	    '</QUANTITY>');
      UTL_FILE.put_line  (lc_file_handle,'<UNITY_PRICE>'		||i.UNITY_PRICE	        ||	    '</UNITY_PRICE>');
      UTL_FILE.put_line  (lc_file_handle,'<AMOUNT>'				||i.AMOUNT	            || 	    '</AMOUNT>');
      UTL_FILE.put_line  (lc_file_handle,'<GST_V>'				||i.GST_V	            ||	    '</GST_V>');
      UTL_FILE.put_line  (lc_file_handle,'<TAXTABLE_AMT>'		||i.TAXTABLE_AMT	    ||	    '</TAXTABLE_AMT>');
      UTL_FILE.put_line  (lc_file_handle,'<GRAND_TOTAL>	'	||i.GRAND_TOTAL	        ||	    '</GRAND_TOTAL>');
      UTL_FILE.put_line  (lc_file_handle,'<PAY_AMOUNT>	'		||i.PAY_AMOUNT	        ||	    '</PAY_AMOUNT>');
                          UTL_FILE.put_line   (lc_file_handle,'</G_COMPANY_CODE>');
      end  loop;
                 UTL_FILE.put_line   (lc_file_handle,'</LIST_S_ITEM_CODE>');
      end   loop;
                   UTL_FILE.put_line   (lc_file_handle,'</LIST_S_COMPANY_CODE>');
     UTL_FILE.FCLOSE(lc_file_handle);              
exception
    when  others    then
    dbms_output.put_line(sqlerrm);              
end xxits_pms_xml_proc; 


         procedure xxits_cms_line_valid_rejected
         as

        cursor  rejected    is
        select  company_id         , item_id           ,vendor_name     ,                       
                manufacturing_date , expiry_date       ,item            ,
                quantity           , gst_v             ,taxtable_amt    ,               
                grand_total        , pay_amount        ,phone_number_ven,                 
                location_ven       ,payment_menthod    ,email_ven       ,     
                amount, error_flag  ,error_msg           
        from    xxits_pms_master_t;
begin

    for i in rejected
    loop
            if  i.error_flag  ='e'then
                insert into xxits_rejected_line_t(company_id         , item_id           ,vendor_name     ,                       
                                                manufacturing_date , expiry_date       ,item            ,
                                                quantity           , gst_v             ,taxtable_amt    ,               
                                                grand_total        , pay_amount        ,phone_number_ven,                 
                                                location_ven       ,payment_menthod    ,email_ven       ,     
                                                amount)values
                                                (i.company_id         , i.item_id           ,i.vendor_name      ,                       
                                                i.manufacturing_date , i.expiry_date       ,i.item              ,
                                                i.quantity           , i.gst_v             ,i.taxtable_amt      ,               
                                                i.grand_total        , i.pay_amount        ,i.phone_number_ven  ,                 
                                                i.location_ven       ,i.payment_menthod    ,i.email_ven         ,     
                                                i.amount);
            commit;
            end if;


            if  i.error_flag  ='v'then
                insert into xxits_validation_line_t(company_id         , item_id           ,vendor_name     ,                       
                                                manufacturing_date , expiry_date       ,item            ,
                                                quantity           , gst_v             ,taxtable_amt    ,               
                                                grand_total        , pay_amount        ,phone_number_ven,                 
                                                location_ven       ,payment_menthod    ,email_ven       ,     
                                                amount)values
                                                (i.company_id         , i.item_id           ,i.vendor_name      ,                       
                                                i.manufacturing_date , i.expiry_date       ,i.item              ,
                                                i.quantity           , i.gst_v             ,i.taxtable_amt      ,               
                                                i.grand_total        , i.pay_amount        ,i.phone_number_ven  ,                 
                                                i.location_ven       ,i.payment_menthod    ,i.email_ven         ,     
                                                i.amount);
                update  xxits_pms_master_t
                set     error_flag      ='p',
                        error_msg       = 'processe'
                where   item_id         =i.item_id;
                
        commit;                                        
        end if;
    end loop;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);
    end;
     procedure   xxits_header_details    
    as
        cursor  company is
        select distinct COMPANY_ID, NAME_C, CATEGORY_TYPE, ADDRESS_LINE1, 
                ADDRESS_LINE2, GST_COM, PHONE_NUMBER_COM,
                ORDER_NO, ORDER_DATE, EMAIL_COM   
        from    xxits_pms_master_t;
    begin
        for i   in company
        loop
        insert  into    xxits_cms_header_t(COMPANY_ID, NAME_C, CATEGORY_TYPE, ADDRESS_LINE1, 
                                            ADDRESS_LINE2, GST_COM, PHONE_NUMBER_COM,
                                            ORDER_NO, ORDER_DATE, EMAIL_COM )values
                                            (i.COMPANY_ID, i.NAME_C, i.CATEGORY_TYPE, i.ADDRESS_LINE1, 
                                            i.ADDRESS_LINE2, i.GST_COM, i.PHONE_NUMBER_COM,
                                            i.ORDER_NO, i.ORDER_DATE, i.EMAIL_COM);
    commit;
    end loop;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);
    end xxits_header_details;
    function   its_date_check  RETURN varchar2
    as 

        ld_date         date:=sysdate;
    begin
        dbms_output.put_line(ld_date);
        return  ld_date;
    exception
    when    others  then
    dbms_output.put_line(sqlerrm);
end;
    function    xxit_date_null_values(P_values  number)RETURN  varchar2
    as
        lc_manufacturing_date    varchar2(40);
    begin
        select   manufacturing_date
        into    lc_manufacturing_date
        FROM    xxits_pms_master_t
        where   item_Id     =  P_values;
        
        if  lc_manufacturing_date  is  not null    then
            RETURN  'yes';
        else
            return  'no';
        end if;
    exception
        when  others    then
        dbms_output.put_line(sqlerrm);    
    end;
    procedure xxits_cms_line_t_proc
    as
    cursor  line    is
    select  company_id         , item_id           ,vendor_name     ,                       
            manufacturing_date , expiry_date       ,item            ,
            quantity           , gst_v             ,taxtable_amt    ,               
            grand_total        , pay_amount        ,phone_number_ven,                 
            location_ven       ,payment_menthod    ,email_ven       ,     
            amount, error_flag  ,error_msg           
    from    xxits_pms_master_t;
    begin

    for i in line
    loop
                insert into xxits_cms_line_t(company_id         , item_id           ,vendor_name     ,                       
                                                manufacturing_date , expiry_date       ,item            ,
                                                quantity           , gst_v             ,taxtable_amt    ,               
                                                grand_total        , pay_amount        ,phone_number_ven,                 
                                                location_ven       ,payment_menthod    ,email_ven       ,     
                                                amount)values
                                                (i.company_id         , i.item_id           ,i.vendor_name      ,                       
                                                i.manufacturing_date , i.expiry_date       ,i.item              ,
                                                i.quantity           , i.gst_v             ,i.taxtable_amt      ,               
                                                i.grand_total        , i.pay_amount        ,i.phone_number_ven  ,                 
                                                i.location_ven       ,i.payment_menthod    ,i.email_ven         ,     
                                                i.amount);
            commit;
    end loop;        
    end; 
end xxits_validation_poject1_pkg;