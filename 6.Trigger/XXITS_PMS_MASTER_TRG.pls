CREATE OR REPLACE NONEDITIONABLE TRIGGER xxits_pms_master_trg AFTER
    INSERT OR UPDATE OR DELETE ON xxits_pms_master_t
    FOR EACH ROW
BEGIN
    if

             deleting     THEN
            INSERT INTO xxits_pms_master_his_t
                (
                company_id,                 name_c,               category_type,
                address_line1,             address_line2,         gst_com,
                phone_number_com ,         order_no,              order_date,
                email_com,                 item_id,               vendor_name,
                email_ven,                 phone_number_ven,      location_ven,
                payment_menthod,           manufacturing_date,    expiry_date,
                item,                      quantity,              unity_price,   
                gst_v,                     taxtable_amt,          grand_total,
                pay_amount,                amount,                 error_flag,
                error_msg
                )
             VALUES 
                (
                :old.company_id,                :old.name_c,                :old.category_type,
                :old.address_line1,             :old.address_line2,         :old.gst_com,
                :old.phone_number_com ,         :old.order_no,              :old.order_date,
                :old.email_com,                 :old.item_id,               :old.vendor_name,
                :old.email_ven,                 :old.phone_number_ven,      :old.location_ven,
                :old.payment_menthod,           :old.manufacturing_date,    :old.expiry_date,
                :old.item,                      :old.quantity,              :old.unity_price,   
                :old.gst_v,                     :old.taxtable_amt,          :old.grand_total,
                :old.pay_amount,                :old.amount,                :old.error_flag,
                :old.error_msg
                );
    end if;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END xxits_pms_master_trg;