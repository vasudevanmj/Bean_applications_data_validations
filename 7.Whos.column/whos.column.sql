---table
create  table   xxits_pms_users_t
(
    user_id             number                              ,
    user_name           varchar2(40)                        ,
    creation_date       date default '12-sep-2024'          ,
    created_by          varchar2(40) default  'vasu devan'  ,            
    last_update_date    date                                ,               
    last_update_by      varchar2(50)                        ,
    last_update_login   varchar2(50)                                               
);

---dml
insert  into    xxits_pms_users_t(user_id,user_name)values(1,'saravanan');

insert  into    xxits_pms_users_t(user_id,user_name)values(2,'ram kumar');

create  or  replace  procedure xxits_pms_users_proc
                                        
                                        (   p_user_id           in number       ,   
                                            p_last_update_date  in date         ,
                                            p_last_update_by    varchar2        ,
                                            p_last_update_login varchar2   
                                        )
as                                        
begin
    update  xxits_pms_users_t  
    set     last_update_date        = 'sysdate'               ,
            last_update_by          = p_last_update_by      ,
            last_update_login       = p_last_update_login   
    where   user_id                 = p_user_id;

exception
    when others then
    dbms_output.put_line(sqlerrm);
end;



select  *   from   xxits_pms_users_t; 
