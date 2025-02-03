
CREATE  TABLE   TEST   
(
    ID      NUMBER      ,
    DOB     DATE        ,
    AGE     NUMBER      
);

INSERT  INTO   TEST (ID,DOB)VALUES(1,'17-SEP-2003');

UPDATE  TEST
SET  AGE    = abs( round ((DOB -sysdate)   /365))
where   ID  =   1;

UPDATE TEST
SET AGE = (SYSDATE - DOB) / 365
WHERE ID = 1;
/
SELECT * FROM test

