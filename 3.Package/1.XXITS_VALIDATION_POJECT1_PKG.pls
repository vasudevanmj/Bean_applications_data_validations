create or replace NONEDITIONABLE package xxits_validation_poject1_pkg
as

    function    xxits_validation_email_duplicate        (p_email_d      in  varchar2)      return  varchar2;
    function    xxit_validation_email_formate           (p_email_id     in  varchar2)      return varchar2;
    function    xxits_validation_phone_formate          (p_phone_number in  number)        return varchar2;
    function    xxits_validation_phone_duplicate        (p_phone        in  number)        return varchar2;
    function    xxit_validation_payment_formate         (p_paymnet      in varchar2)       return varchar2;
    function    xxit_validation_payment_balance_formate (P_item         in  varchar2)      return varchar2;           
    procedure   xxits_validation_master_t;
    procedure   xxits_cms_details_reports;
    procedure xxits_pms_xml_proc(p_ERROR_FLAG  in  varchar2);
    procedure   xxits_cms_line_valid_rejected;
    procedure   xxits_header_details;
    function    its_date_check  return varchar2;
    function    xxit_date_null_values(P_values  number)RETURN  varchar2;
    procedure xxits_cms_line_t_proc;
    
end xxits_validation_poject1_pkg;