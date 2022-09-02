-- Remove tables to prepare for re-creation.
DROP TABLE order_list;
DROP TABLE food_order;
DROP TABLE customer;
DROP TABLE menu;
DROP TABLE category;
DROP TABLE staff;

-- [Re-]create tables
CREATE TABLE staff (
    staff_id   NUMBER(4) NOT NULL,
    staff_name VARCHAR(25) NOT NULL,
    date_join  DATE,
    birth_date DATE,
    PRIMARY KEY ( staff_id )
);

CREATE TABLE category (
    cat_id      VARCHAR(5) NOT NULL,
    description VARCHAR(30) NOT NULL,
    min_price   NUMBER(6, 2),
    max_price   NUMBER(6, 2),
    PRIMARY KEY ( cat_id )
);

CREATE TABLE menu (
    menu_id         VARCHAR(5) NOT NULL,
    description     VARCHAR(30) NOT NULL,
    price           NUMBER(6, 2),
    date_introduced DATE,
    cat_id          VARCHAR(5),
    remarks         VARCHAR(50),
    PRIMARY KEY ( menu_id ),
    FOREIGN KEY ( cat_id ) REFERENCES category ( cat_id )
);

CREATE TABLE customer (
    cust_no    NUMBER(7) NOT NULL,
    cust_name  VARCHAR(25) NOT NULL,
    email      VARCHAR(35),
    phone      VARCHAR(14),
    birth_date DATE,
    gender     CHAR(1),
    PRIMARY KEY ( cust_no ),
    CONSTRAINT chk_email CHECK ( REGEXP_LIKE ( email, '^[a-zA-Z]\w+@(\S+)$' ) ),
    CONSTRAINT chk_gender CHECK ( upper(gender) IN ( 'M', 'F' ) )
);

CREATE TABLE food_order (
    order_no       NUMBER(7) NOT NULL,
    order_date     DATE,
    cust_no        NUMBER(7),
    staff_no       NUMBER(4),
    total_items    NUMBER(2),
    food_amount    NUMBER(7, 2),
    sst            NUMBER(6, 2),
    service_charge NUMBER(6, 2),
    PRIMARY KEY ( order_no ),
    FOREIGN KEY ( cust_no ) REFERENCES customer ( cust_no ),
    FOREIGN KEY ( staff_no ) REFERENCES staff ( staff_id )
);

CREATE TABLE order_list (
    order_no NUMBER(7) NOT NULL,
    menu_id  VARCHAR(5) NOT NULL,
    quantity NUMBER(2),
    price    NUMBER(6, 2),
    PRIMARY KEY ( order_no, menu_id ),
    FOREIGN KEY ( order_no ) REFERENCES food_order ( order_no ),
    FOREIGN KEY ( menu_id ) REFERENCES menu ( menu_id )
);

-- Add data into tables.
INSERT INTO staff VALUES(1001,'Christina','01-JAN-2011','01-JAN-1998');

INSERT INTO category VALUES ('DR01','Carbonated drinks',1.00,10.00);
INSERT INTO category VALUES ('DB01','Beverages',3.00,15.00);
INSERT INTO category VALUES ('ST01','Starters',4.5,25.00);

INSERT INTO menu VALUES('M001','Sparkling Lime',3.90,'01-JAN-2014','DR01','Refreshing soda lime');
INSERT INTO menu VALUES('M091','Cappuccino',5.90,'01-JAN-2014','DB01','Made with quality Espresso brew');
INSERT INTO menu VALUES('M101','Crab stick and Fish Fingers',11.95,'24-FEB-2015','ST01','Delicious finger food');

INSERT INTO customer VALUES(1001,'Ali','aBc@tarc.edu.my',null,null,'M');

INSERT INTO food_order VALUES(1001, '01-JUN-2016',1001,1001,2,13.7,0.82,1.37);
INSERT INTO food_order VALUES(1002, '03-JUN-2016',1001,1001,3,27.65,1.66,2.76);
INSERT INTO food_order VALUES(1003, '05-JUN-2016',1001,1001,2,35.7,2.14,3.57);

INSERT INTO order_list VALUES(1001,'M001',2,3.90);
INSERT INTO order_list VALUES(1001,'M091',1,5.90);
INSERT INTO order_list VALUES(1002,'M001',1,3.90);
INSERT INTO order_list VALUES(1002,'M091',2,5.90);
INSERT INTO order_list VALUES(1002,'M101',1,11.95);
INSERT INTO order_list VALUES(1003,'M091',2,5.90);
INSERT INTO order_list VALUES(1003,'M101',2,11.95);

-- Add salary column to staff table.
ALTER TABLE staff
ADD (salary NUMBER(7,2) DEFAULT 900.00);

INSERT INTO staff VALUES(2001,'Wendy','01-JAN-2012','02-JAN-1995',2000);
INSERT INTO staff VALUES(2002,'McDonald','01-JAN-2012','03-FEB-1994',2200);
INSERT INTO staff VALUES(2003,'Cha Kai','01-JAN-2012','04-MAR-1993',2300);

INSERT INTO category VALUES('RC001','Rice main course',10.00,15.00);
INSERT INTO category VALUES('P0001','Pasta main course',12.00,20.00);
INSERT INTO category VALUES('PZ001','Pizza main course',11.00,25.00);

INSERT INTO menu VALUES('RC101','Pineapple Fried Rice',12.50,'01-JAN-2014','RC001','A Thai delicacy');
INSERT INTO menu VALUES('RC102','Cheese Baked Rice',13.99,'01-JAN-2014','RC001','Chef''s recommendation');
INSERT INTO menu VALUES('RC103','Seafood Risotto',14.50,'01_FEB-2014','RC001','Italian Special');
INSERT INTO menu VALUES('P201','Asian Fusion Pasta',12.50,'01-JAN-2014','P0001','East meets West');
INSERT INTO menu VALUES('P301','Chicken Cabonara',13.00,'01-FEB-2014','P0001','All time favourite');
INSERT INTO menu VALUES('P401','3-in-1 Pasta',12.50,'01-FEB-2014','P0001','Fusilli,Fettuccine and Pene');
INSERT INTO menu VALUES('PZ601','Chicken Pizza',11.50,'01-MAR-2013','PZ001','Classic favourite');
INSERT INTO menu VALUES('PZ602','Vegeterian Pizza',12.00,'01-MAR-2013','PZ001','For vege lovers');
INSERT INTO menu VALUES('PZ603','Satay Mixed',19.90,'01-MAR-2103','PZ001','Malaysian best seller');
INSERT INTO menu VALUES('PZ604','Meat Platter Mix',25.00,'01-APR-2014','PZ001','Beef,Chicken and Turkey Ham');

INSERT INTO customer VALUES(6789,'Mr Lee','mrlee@email.com',null,'01-FEB-1986','M');
INSERT INTO customer VALUES(6788,'Ms Chan','mschan@email.com',null,'01-FEB-1995','F');
INSERT INTO customer VALUES(6787,'Mr Steven','mrsteven@email.com',null,'01-MAR-1990','M');
INSERT INTO customer VALUES(6786,'En Mohd','enmohd@email.com',null,'01-APR-1974','M');
INSERT INTO customer VALUES(6785,'Nosmo King','NoSmoking@email.com',null,'01-MAY-1979','M');
INSERT INTO customer VALUES(6784,'Ms Wong','mswong@email.com',null,'01-AUG-1992','F');

INSERT INTO food_order VALUES(3001,'25-JUN-2016',6789,2001,3,51.49,3.09,5.15);
INSERT INTO food_order VALUES(3002,'25-JUN-2016',6788,2002,4,52.99,3.18,5.30);
INSERT INTO food_order VALUES(3003,'25-JUN-2016',6787,2003,4,73.4,4.40,7.34);

INSERT INTO order_list VALUES(3001,'RC101',1,12.50);
INSERT INTO order_list VALUES(3001,'RC102',1,13.99);
INSERT INTO order_list VALUES(3001,'PZ604',1,25.00);
INSERT INTO order_list VALUES(3002,'RC102',1,13.99);
INSERT INTO order_list VALUES(3002,'RC103',1,14.50);
INSERT INTO order_list VALUES(3002,'PZ602',1,12.00);
INSERT INTO order_list VALUES(3002,'P201',1,12.50);
INSERT INTO order_list VALUES(3003,'RC103',2,14.50);
INSERT INTO order_list VALUES(3003,'P301',1,13.00);
INSERT INTO order_list VALUES(3003,'PZ603',1,19.90);
INSERT INTO order_list VALUES(3003,'PZ601',1,11.50);

COMMIT;