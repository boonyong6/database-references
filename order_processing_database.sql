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

COMMIT;