---start 
--1
update  xxits_pms_master_t
set     EMAIL_VEN  =  'rajesh@232.com'
where   item_id    =   201;
--2
update  xxits_pms_master_t
set     EMAIL_VEN  =  'lumesh@232.com'
where   item_id    =   203;
--3
update  xxits_pms_master_t
set     PHONE_NUMBER_VEN  =  9807654320
where   item_id    =   205;

--4
update  xxits_pms_master_t
set     PHONE_NUMBER_VEN  =  1029384756
where   item_id    =   206;

--5
update  xxits_pms_master_t
set     PAYMENT_MENTHOD  =  'cash'
where   item_id    =   207;

--6

update  xxits_pms_master_t
set     PAY_AMOUNT  =  221250
where   item_id    =   208;

--7

update  xxits_pms_master_t
set     MANUFACTURING_DATE  =  '12-sep-2022'
where   item_id    =   215;

---8

update  xxits_pms_master_t
set     PAYMENT_MENTHOD  =  'cash'
where   item_id    =  216;

---9
update  xxits_pms_master_t
set     PHONE_NUMBER_VEN  =  7867564532
where   item_id    =   220;

commit;

---end