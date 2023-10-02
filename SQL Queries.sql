/*
Course: INSY437: Managinig data and database
Title: Database Design and Implementation for IKEA's Online Presence
Submission date : 2023-04-19
Team Number: 1
Students' Name: Maëlys Boudier; Louis Roncador; Alexander Sukhanov
                Jonathan Steinberg; Teghwin Kohli; Thomas Atchison



Table of Content (beginning code line):
- RDBMS Creation script:         21
- Inserting Mock Data:          199
- Functional SQL statements:   1123
- Informational queries:       1142
- Cypher creation statements:  1234
- Cypher queries:              1331

*/

-- RDBMS Creation script

CREATE TABLE CUSTOMERS (
    CUSTOMER_ID int PRIMARY KEY,
    CUSTOMER_FIRST_NAME varchar(50) NOT NULL,
    CUSTOMER_LAST_NAME varchar(50) NOT NULL,
    EMAIL_ADDRESS varchar(50) NOT NULL,
    PHONE_NUMBER char(10) NULL,
    ADDRESS_LINE1 varchar(50) NULL,
    ADDRESS_LINE2 varchar(50) NULL,
    CITY varchar(50) NULL,
    PROVINCE char(2) NULL,
    POSTAL_CODE varchar(6) NULL,
    COUNTRY varchar(50) NULL,
    BUSINESS BOOLEAN NULL
);

CREATE TABLE ROOM(
    ROOM_ID int NOT NULL,
    ROOM_HEALINE varchar(100) NOT NULL,
    ROOM_DESCRIPTION varchar(1000) NULL,
 CONSTRAINT PK_ROOM PRIMARY KEY (ROOM_ID )
)
;

CREATE TABLE ROOM_CONTAINS(
	RELATION_ID int NOT NULL, 
    ROOM_ID int NOT NULL, 
    SUPER_ROOM_ID int NOT NULL,
    CONSTRAINT PK_RELATION PRIMARY KEY (RELATION_ID )
)
;

CREATE TABLE ARTICLE(
    ARTICLE_NUMBER int NOT NULL,
    ARTICLE_NAME varchar(100) NOT NULL,
    ARTICLE_DESCRIPTION varchar(500) NULL,
    DESIGNER varchar(100) NULL,
    COLOR varchar(100) NULL,
    ASSEMBLY_INSTRUCTION varchar(2000) NULL,
    ASSEMBLY_LEVEL char(10) NULL,
    ARTICLE_TYPE char(10) NULL,
    MSRP NUMERIC(10,2) NULL,
    COGS NUMERIC(10,2) NULL,
    DISCOUNTED_PRICE NUMERIC(10,2) NULL,
    QTY_IN_STOCK INT NULL,
    ROOM_ID INT NOT NULL,
 CONSTRAINT PK_ARTICLE PRIMARY KEY(ARTICLE_NUMBER)
);

CREATE TABLE BED(
    BED_ARTICLE_NUMBER int PRIMARY KEY,
    BED_LENGTH numeric(8, 2) NULL,
    BED_WIDTH numeric(8, 2) NULL,
    MATTRESS_LENGTH numeric(8, 2) NULL,
    MATTRESS_WIDTH numeric(8, 2) NULL,
    FOOTBOARD_HEIGHT numeric(8, 2) NULL,
    HEADBOARD_HEIGHT numeric(8, 2) NULL)
    ;

CREATE TABLE CHAIR(
    CHAIR_ARTICLE_NUMBER int NOT NULL,
    CHAIR_HEIGHT numeric(8, 2) NULL,
    CHAIR_WIDTH numeric(8, 2) NULL,
    CHAIR_DEPTH numeric(8, 2) NULL,
    SEAT_HEIGHT numeric(8, 2) NULL,
    SEAT_WIDTH numeric(8, 2) NULL,
    SEAT_DEPTH numeric(8, 2) NULL,
 CONSTRAINT PK_CHAIR PRIMARY KEY (CHAIR_ARTICLE_NUMBER))
;

CREATE TABLE TABLE(
    TABLE_ARTICLE_NUMBER int NOT NULL,
    TABLE_HEIGHT numeric(6, 2) NULL,
    TABLE_WIDTH numeric(6, 2) NULL,
    TABLE_DEPTH numeric(6, 2) NULL,
    MAX_LOAD numeric(10, 2) NULL,
 CONSTRAINT PK_TABLE PRIMARY KEY (TABLE_ARTICLE_NUMBER)) 
;


CREATE TABLE ORDERS(
    ORDER_ID int NOT NULL,
    ORDER_DATE date NULL,
    ORDER_STATUS varchar(20) NULL,
    DELIVERY_NOTES varchar(250) NULL,
    ORDER_SOURCE varchar(50) NULL,
    GROSS_PRICE NUMERIC(10,2) NULL,
    DELIVERY_COST NUMERIC(10,2) NULL,
    CUSTOMER_ID int NOT NULL,
 CONSTRAINT PK_ORDERS PRIMARY KEY (ORDER_ID))
;


CREATE TABLE PAYMENTS(
    PAYMENT_ID int NOT NULL,
    PAYMENT_DATE date NULL,
    AMOUNT NUMERIC(10,2) NULL,
    PAYMENT_METHOD varchar(15) NULL,
    PAYMENT_STATUS varchar(10) NULL,
    PAYMENT_PLAN varchar(10) NULL,
    ORDER_ID int NOT NULL,
 CONSTRAINT PK_PAYMENTS PRIMARY KEY (PAYMENT_ID )) 
;


CREATE TABLE ORDER_DETAILS(
    ORDER_ID int NOT NULL,
    ARTICLE_NUMBER int NOT NULL,
    QTY_ORDERED int NOT NULL,
    DISCOUNT bit NULL
)
;


-- STOP HERE
-- BECAUSE CUSTOMERID SHOULD BE AUTO INCREMENTED & BASE CANNOT DO 
-- IDENTITY(1,1) OR AUTO_INCREMENT, MUST DO IT MANUALLY
-- 
-- Before any entry; CUSTOMER_ID has been switched to AUTO INCREMENT MANUALLY BECAUSE BASE 
-- COULD NOT UNDERSTAND IT
--  ALL THE FOLLOWING DID NOT WORK
-- ALTER TABLE CUSTOMERS MODIFY CUSTOMER_ID INT AUTO_INCREMENT;
-- ALTER TABLE CUSTOMERS MODIFY COLUMN CUSTOMER_ID INT AUTO_INCREMENT;
-- ALTER TABLE CUSTOMERS MODIFY CUSTOMER_ID INT IDENTITY(1,1);



ALTER TABLE BED ADD  CONSTRAINT FK_BED_ARTICLE FOREIGN KEY(BED_ARTICLE_NUMBER)
REFERENCES ARTICLE (ARTICLE_NUMBER)
;

ALTER TABLE ARTICLE  ADD  CONSTRAINT FK_ROOM_ARTICLE FOREIGN KEY(ROOM_ID)
REFERENCES ROOM (ROOM_ID)
;

ALTER TABLE ROOM_CONTAINS  ADD  CONSTRAINT FK_ROOM_RELATION FOREIGN KEY(ROOM_ID)
REFERENCES ROOM (ROOM_ID)
;

ALTER TABLE ROOM_CONTAINS  ADD  CONSTRAINT FK_SUPER_ROOM_RELATION FOREIGN KEY(SUPER_ROOM_ID)
REFERENCES ROOM (ROOM_ID)
;

ALTER TABLE CHAIR   ADD  CONSTRAINT FK_CHAIR_ARTICLE FOREIGN KEY(CHAIR_ARTICLE_NUMBER)
REFERENCES ARTICLE (ARTICLE_NUMBER)
;

ALTER TABLE ORDER_DETAILS   ADD  CONSTRAINT FK_ORDER_DETAILS_ARTICLE FOREIGN KEY(ARTICLE_NUMBER)
REFERENCES ARTICLE (ARTICLE_NUMBER)
;

ALTER TABLE ORDER_DETAILS   ADD  CONSTRAINT FK_ORDER_DETAILS_ORDERS FOREIGN KEY(ORDER_ID)
REFERENCES ORDERS (ORDER_ID)
;

ALTER TABLE ORDERS   ADD  CONSTRAINT FK_ORDERS_CUSTOMERS FOREIGN KEY(CUSTOMER_ID)
REFERENCES CUSTOMERS (CUSTOMER_ID)
;

ALTER TABLE PAYMENTS   ADD  CONSTRAINT FK_PAYMENTS_ORDERS FOREIGN KEY(ORDER_ID)
REFERENCES ORDERS (ORDER_ID)
;

ALTER TABLE TABLE   ADD  CONSTRAINT FK_TABLE_ARTICLE FOREIGN KEY(TABLE_ARTICLE_NUMBER)
REFERENCES ARTICLE (ARTICLE_NUMBER)
;











-- *************** Inserting Mock Data for SQL Queries ***************


-- DOMINIQUE WELT
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,ADDRESS_LINE2
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Dominique'
           ,'Welt'
           ,4384445555
           ,'dwelt@gmmail.com'
           ,'727 Rue Saint-Hubert'
           ,'appt 2'
           ,'Montreal'
           ,'QC'
           ,'J8Y3W7'
           ,'CA'
           ,1)
;

-- TEGHWIN KOHLI
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Teghwin'
           ,'Kohli'
           ,5145145144
           ,'tkohl@gmmail.com'
           ,'938 Rue Sainte-Catherine'
           ,'Montreal'
           ,'QC'
           ,'J4J3Y2'
           ,'CA'
           ,1)
;

-- Maelys Boudier
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,ADDRESS_LINE2
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Maelous'
           ,'Bydier'
           ,4386148221
           ,'mbud@gmmail.com'
           ,'861 Rue Sainte-Catherine'
           ,'appt 3'
           ,'Quebec City'
           ,'QC'
           ,'J8Y3W7'
           ,'CA'
           ,1)
;

-- Jon StinBourg
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Jon'
           ,'Stinbourg'
           ,9712479935
           ,'jon.stinbourg@icloud.com'
           ,'804 Avenue Ottawa'
           ,'Ottawa'
           ,'ON'
           ,'V0V0V0'
           ,'CA'
           ,0)
;



-- Luis Ruingator
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Luis'
           ,'Ruingator'
           ,1057166181
           ,'luis.ruingator@icloud.com'
           ,'708 Boulevard Toronto'
           ,'Toronto'
           ,'ON'
           ,'A0A1A0'
           ,'CA'
           ,0)
;

-- Tom Hutchinson
INSERT INTO CUSTOMERS
           (CUSTOMER_FIRST_NAME
           ,CUSTOMER_LAST_NAME
           ,PHONE_NUMBER
           ,EMAIL_ADDRESS
           ,ADDRESS_LINE1
           ,ADDRESS_LINE2
           ,CITY
           ,PROVINCE
           ,POSTAL_CODE
           ,COUNTRY
           ,BUSINESS)
     VALUES
           ('Tom'
           ,'Hutchinson'
           ,2612415025
           ,'tom.hutchinson@hotmail.com'
           ,'299 Drive Vancouver'
           ,'apt 2'
           ,'Vancouver'
           ,'BC'
           ,'H0H0H0'
           ,'CA'
           ,0)
;


-- CREATE ROOMS
INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION)
     VALUES
           (101
           ,'Tables & desks'
           ,'Gather around the table and hear the family news, play a game, help with homework or set your stuff down. With our tables in a wide range of sizes and styles, youll find one that fits whatever you want to do in whatever space you have. You can find a table online or test them out in our stores.'
           )
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
         )
     VALUES
           (111
           ,'Coffee & side tables'
           ,'With different styles that match our seating and other furniture, our coffee tables and end tables for living room take care of everything you like to have close by, from remote controls to magazines.  Go sleek and minimal or ultra-organized by choosing a coffee table with storage. Either way, your space will get a style boost. And your coffee cup gets a new home away from home.'
           )
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION)
     VALUES
           (112
           ,'Coffee tables'
           ,'With all the gadgets in your life today, a coffee table makes more sense than ever. About a metre or so away from the sofa is the ideal place to park your TV remote control, your phone and all your other gadgets. Many of ours have a built-in lower shelf so you can keep your magazines and books organized and tidy, too.')
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
           )
     VALUES
           (121
           ,'Dining sets'
           ,'Dining room sets are a fast way to make a dining room look perfectly pulled together. Our dining sets also give you comfort and durability in a big choice of styles. And less time searching for a dining table and chairs means more time for sharing good food and laughter with family and friends.'
          )
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
           )
     VALUES
           (122
           ,'Dining sets up to 6 seats'
           ,'Dining tables are the heroes of the home. What other piece plays so many roles? From home office to game central to party central to, well, the place you eat your meals, it really is the spot that does it all. Ours are sturdy, durable, and will fit up to 6 guests. So find your style and bring one home.'
           )
;


-- Beds
INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION)
     VALUES
           (200
           ,'Beds'
           ,'There are lots of beds, but feeling good when you wake up starts with finding the right one. Choose one thats big enough to stretch out, but cozy enough to snuggle up tight. Our beds and bed frames are built to last for years in a style that youll love just as long.'
           )
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
           )
     VALUES
           (210
           ,'Full, Queen and King beds'
           ,'The best start to your day is a good nights sleep. Our sturdy full/double, queen and king beds in different styles give you comfort and quality, so you wake up with a smile. Many have smart features like built-in storage or are sized so you can slide boxes underneath. Look around our website to find what else you need, like a mattress or pillows, to complete the comfy bed of your dreams.'
           )
;


-- Chairs
INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION)
     VALUES
           (300
           ,'Armchairs & chaise lounges'
           ,'Armchairs are all about individual comfort. That is why we have so many styles to choose from in fabric, leather, and rattan, so you can sit comfortably and get the look you like, too. You will find everything from cozy chaises for conquering that crossword to recliners for your afternoon naps. And many of our fabric covers can be machine-washed or dry-cleaned, too.')
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
           )
     VALUES
           (310
           ,'Armchairs'
           ,'Armchairs are all about individual comfort. That is why we have so many styles to choose from in fabric, leather, and rattan, so you can sit comfortably and get the look you like, too. You will find everything from cozy chaises for conquering that crossword to recliners for your afternoon naps. And many of our fabric covers can be machine-washed or dry-cleaned, too.'
           )
;

INSERT INTO ROOM
           (ROOM_ID
           ,ROOM_HEALINE
           ,ROOM_DESCRIPTION
           )
     VALUES
           (311
           ,'Fabric armchairs'
           ,'Our fabric armchairs were totally designed for comfort. They have everything from high-backed bentwood frames with a springy feel to lushly padded cushions you can sink into. Many have machine-washable covers that you can easily swap out for a refreshing look in your living room. Find your fabric armchair online or in-store.'
           )
;

-- CREATE ROOM RELATIONS
-- SET THE RELATION_ID TO AUTO INCREMENT MANUALLY
INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (111,
           101
           )
           ;
           
INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (112,
           111
           )
           ;

INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (121,
           101
           )
           ;
           
INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (122,
           121
           )
           ;
           
INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (210,
           200
           )
           ;

INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (310,
           300
           )
           ;
           
INSERT INTO ROOM_CONTAINS
           (ROOM_ID
           , SUPER_ROOM_ID
           )
     VALUES
           (311,
           310
           )
           ;

-- ARTICLE ENTRY

-- CHAIRS
-- https://www.ikea.com/ca/en/p/poaeng-armchair-birch-veneer-knisa-light-beige-s49306570/

INSERT INTO ARTICLE
           (ARTICLE_NUMBER
           ,ARTICLE_NAME
           ,ARTICLE_DESCRIPTION
           ,DESIGNER
           ,COLOR
           ,ASSEMBLY_INSTRUCTION
           ,ASSEMBLY_LEVEL
           ,ARTICLE_TYPE
           ,MSRP
           ,COGS
           ,DISCOUNTED_PRICE
           ,QTY_IN_STOCK
           ,ROOM_ID)
     VALUES
           (49306570
           ,'POÄNG'
           ,'POÄNG armchair has stylish curved lines in bentwood, providing nice support for the neck and comfy resilience. Its been in our range for several decades and is still just as popular. Want to try it too?'
           ,'Noboru Nakamura'
           ,'light beige'
           ,'The layer-glued bent wood frame gives the armchair a comfortable resilience, making it perfect to relax in.

The high back provides good support for your neck.

A variety of seat cushion designs makes it easy to change the look of your POÄNG chair and your living room.

To sit even more comfortably and relaxed, you can use the armchair together with a POÄNG footstool.

10-year limited warranty. Read about the terms in the limited warranty brochure.'
           ,'Medium'
           ,'Chair'
           ,119.00
           ,47.50
           ,79.00
           ,1242
           ,311)
;

INSERT INTO CHAIR
           (CHAIR_ARTICLE_NUMBER
           ,CHAIR_HEIGHT
           ,CHAIR_WIDTH
           ,CHAIR_DEPTH
           ,SEAT_HEIGHT
           ,SEAT_WIDTH
           ,SEAT_DEPTH)
     VALUES
           (49306570
           ,100
           ,68
           ,82 
           ,50
           ,56
           ,50)
;




-- BEDS
-- https://www.ikea.com/ca/en/p/malm-bed-frame-high-black-brown-luroey-s69009475/


INSERT INTO ARTICLE
           (ARTICLE_NUMBER
           ,ARTICLE_NAME
           ,ARTICLE_DESCRIPTION
           ,DESIGNER
           ,COLOR
           ,ASSEMBLY_INSTRUCTION
           ,ASSEMBLY_LEVEL
           ,ARTICLE_TYPE
           ,MSRP
           ,COGS
           ,DISCOUNTED_PRICE
           ,QTY_IN_STOCK
           ,ROOM_ID)
     VALUES
           (69009475
           ,'MALM Bed frame'
           ,'A clean design with solid wood veneer. Place the bed on its own or with the headboard against a wall. If you need space for extra bedding, add MALM bed storage boxes on casters.'
           ,'Eva Lilja Löwenhielm/IKEA of Sweden'
           ,'black-brown'
           ,'Wood veneer gives you the same look, feel and beauty as solid wood with unique variations in grain, color and texture.This versatile bed frame will look great with your choice of textiles and bedroom furniture.You can sit up comfortably in bed thanks to the high headboard – just prop some pillows behind your back and you will have a comfortable place to read or watch TV.You can easily vacuum under the bed frame to keep the space clean and dust-free.Adjustable bed sides allow you to use mattresses of different thicknesses.17 layer-glued slats adjust to your body weight and increase the suppleness of the mattress.'
           ,'High'
           ,'Bed'
           ,329.00
           ,214.25
           ,299.00
           ,342
           ,210)
;


INSERT INTO BED
           (BED_ARTICLE_NUMBER
           ,BED_LENGTH
           ,BED_WIDTH
           ,MATTRESS_LENGTH
           ,MATTRESS_WIDTH
           ,FOOTBOARD_HEIGHT
           ,HEADBOARD_HEIGHT)
     VALUES
           (69009475
           ,211
           ,168
           ,202
           ,152
           ,38
           ,100)
;




-- Tables
-- Big Table
-- https://www.ikea.com/ca/en/p/moerbylanga-lillanaes-table-and-6-chairs-oak-veneer-brown-stained-chrome-plated-gunnared-beige-s19495204/

INSERT INTO ARTICLE
           (ARTICLE_NUMBER
           ,ARTICLE_NAME
           ,ARTICLE_DESCRIPTION

           ,COLOR
           ,ASSEMBLY_INSTRUCTION
           ,ASSEMBLY_LEVEL
           ,ARTICLE_TYPE
           ,MSRP
           ,COGS
           ,DISCOUNTED_PRICE
           ,QTY_IN_STOCK
           ,ROOM_ID)
     VALUES
           (19495204
           ,'MÖRBYLÅNGA / LILLÅNÄS'
           ,'This dining set seats up to 6, offering modern appeal and comfort for all-day activities. The padded seat with removable cover is shaped to reduce pressure and the backrest has a relaxing flexy feel.'
           ,'oak veneer brown stained/chrome plated Gunnared beige'
           ,'Oak is an exceedingly strong and durable hardwood with a prominent grain. It darkens beautifully with age acquiring a golden-brown undertone. 
           Every table is unique, with varying grain pattern and natural color shifts that are part of the charm of wood. 
           This generously sized table and its durable construction offers space for all types of activities like dining, homework, drawing or playing games with the kids.
           Dine in style and comfort. This upholstered chair is perfect for long meals, spending precious moments with family and friends or for indulging in some relaxing me-time.
           The cover is easy to keep clean as it is removable and can be washed.
           This cover is made of dope-dyed GUNNARED fabric in polyester. It is a durable fabric with a wool-like feel, a warm look and a two-toned melange effect.'
           ,'High'
           ,'Table'
           ,1949.00
           ,1203.40
           ,1649.00
           ,65
           ,122)
;

INSERT INTO TABLE
           (TABLE_ARTICLE_NUMBER
           ,TABLE_WIDTH
           ,TABLE_DEPTH)
     VALUES
           (19495204
           ,100
           ,220
           )

;


INSERT INTO ARTICLE
           (ARTICLE_NUMBER
           ,ARTICLE_NAME
           ,ARTICLE_DESCRIPTION
           ,DESIGNER
           ,COLOR
           ,ASSEMBLY_INSTRUCTION
           ,ASSEMBLY_LEVEL
           ,ARTICLE_TYPE
           ,MSRP
           ,COGS
           ,DISCOUNTED_PRICE
           ,QTY_IN_STOCK
           ,ROOM_ID)
     VALUES
           (70319028
           ,'LACK Side table'
           ,'LACK side table is easy to match with other furnishings. The honeycomb structured paper filling construction adds strength to the table while keeping it lightweight so it´s easy to move around.'
           ,'IKEA of Sweden'
           ,'white stained oak effect'
           ,'The design of this LACK table makes it easy to use for various needs and to match with other furnishings in your home.

The honeycomb paper construction adds strength to the table while keeping it lightweight. This makes it easier to bring home, place where you like and move around throughout the home.

Easy to assemble.

May be combined with other products in the LACK series. Also matches well with the KALLAX series.'
           ,'Low'
           ,'Table'
           ,19.99
           ,11.05
           ,14.99
           ,465
           ,112)
;

INSERT INTO TABLE
           (TABLE_ARTICLE_NUMBER
           ,TABLE_HEIGHT
           ,TABLE_WIDTH
           ,TABLE_DEPTH
           ,MAX_LOAD)
     VALUES
           (70319028
           ,45
           ,55
           ,55
           ,25
           )

;


-- https://www.ikea.com/ca/en/p/lack-side-table-white-30449908/#content 

INSERT INTO ARTICLE
           (ARTICLE_NUMBER
           ,ARTICLE_NAME
           ,ARTICLE_DESCRIPTION
           ,DESIGNER
           ,COLOR
           ,ASSEMBLY_INSTRUCTION
           ,ASSEMBLY_LEVEL
           ,ARTICLE_TYPE
           ,MSRP
           ,COGS
           ,DISCOUNTED_PRICE
           ,QTY_IN_STOCK
           ,ROOM_ID)
     VALUES
           (30449908
           ,'LACK Side table'
           ,'This LACK table in white is easy to match with other furnishings. Thanks to the unique construction, its easy to assemble, lift and move around - and we can keep the prices down, so your spirits go up.'
           ,'White'
           ,'IKEA of Sweden'
           ,'The design of this LACK table makes it easy to use for various needs and to match with other furnishings in your home.

The honeycomb paper construction adds strength to the table while keeping it lightweight. This makes it easier to bring home, place where you like and move around throughout the home.

Easy to assemble.

May be combined with other products in the LACK series. Also matches well with the KALLAX series.'
           ,'Low'
           ,'Table'
           ,14.99
           ,9.05
           ,12.99
           ,786
           ,112)
;


INSERT INTO TABLE
           (TABLE_ARTICLE_NUMBER
           ,TABLE_HEIGHT
           ,TABLE_WIDTH
           ,TABLE_DEPTH
           ,MAX_LOAD)
     VALUES
           (30449908
           ,45
           ,55
           ,55
           ,25
           )

;

-- ORDER ENTRY
-- Orders
INSERT INTO ORDERS
           (ORDER_ID
            ,ORDER_DATE
           ,ORDER_STATUS
           ,DELIVERY_NOTES
           ,ORDER_SOURCE
           ,GROSS_PRICE
           ,DELIVERY_COST
           ,CUSTOMER_ID)
     VALUES
           (101
            ,'2023-02-19'
           ,'Delivered'
           ,'left at door'
           ,'Email'
           ,2107
           ,200
           ,0)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (101
           ,49306570
           ,2
           ,1)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (101
           ,19495204
           ,1
           ,0)
;


-- ORDER 2

INSERT INTO ORDERS
           (ORDER_ID
            ,ORDER_DATE
           ,ORDER_STATUS
           ,ORDER_SOURCE
           ,GROSS_PRICE
           ,DELIVERY_COST
           ,CUSTOMER_ID)
     VALUES
           (102
            ,'2023-03-19'
           ,'Cancelled'
           ,'Phone'
           ,8225
           ,1000
           ,1)
;


INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (102
           ,69009475
           ,25
           ,0)
;


-- ORDER 3

INSERT INTO ORDERS
           (ORDER_ID
           ,ORDER_DATE
           ,ORDER_STATUS
           ,ORDER_SOURCE
           ,GROSS_PRICE
           ,DELIVERY_COST
           ,CUSTOMER_ID)
     VALUES
           (103
            ,'2023-03-24'
           ,'Transit'
           ,'Social Media'
           ,14.99
           ,10
           ,4)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (103
           ,30449908
           ,1
           ,0)
;


-- ORDER 4

INSERT INTO ORDERS
           (ORDER_ID,
           ORDER_DATE
           ,ORDER_STATUS
           ,ORDER_SOURCE
           ,GROSS_PRICE
           ,DELIVERY_COST
           ,CUSTOMER_ID)
     VALUES
           (104,
           '2023-03-24'
           ,'Processing'
           ,'Recurring Customer'
           ,153.98
           ,0
           ,3)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (104
           ,49306570
           ,1
           ,0)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (104
           ,70319028
           ,1
           ,1)
;


-- ORDER 5


INSERT INTO ORDERS
           (ORDER_ID
           ,ORDER_DATE
           ,ORDER_STATUS
           ,ORDER_SOURCE
           ,GROSS_PRICE
           ,DELIVERY_COST
           ,CUSTOMER_ID)
     VALUES
           (109
           ,'2023-01-24'
           ,'Delivered'
           ,'Recurring Customer'
           ,14990
           ,10000
           ,5)
;

INSERT INTO ORDER_DETAILS
           (ORDER_ID
           ,ARTICLE_NUMBER
           ,QTY_ORDERED
           ,DISCOUNT)
     VALUES
           (109
           ,70319028
           ,1000
           ,1)
;

-- PAYMENT ENTRY
INSERT INTO PAYMENTS
           (PAYMENT_ID
           ,PAYMENT_DATE
           ,AMOUNT
           ,PAYMENT_METHOD
           ,PAYMENT_STATUS
           ,PAYMENT_PLAN
           ,ORDER_ID)
     VALUES
           (1000
           ,'2023-02-19'
           ,2651.90
           ,'Mastercard'
           ,'Received'
           ,'Full'
           ,101)
;

INSERT INTO PAYMENTS
           (PAYMENT_ID
           ,PAYMENT_DATE
           ,AMOUNT
           ,PAYMENT_METHOD
           ,PAYMENT_STATUS
           ,PAYMENT_PLAN
           ,ORDER_ID)
     VALUES
           (1001
           ,'2023-03-19'
           ,10604.14
           ,'VISA'
           ,'Refunded'
           ,'Full'
           ,102)
;

INSERT INTO PAYMENTS
           (PAYMENT_ID
           ,PAYMENT_DATE
           ,AMOUNT
           ,PAYMENT_METHOD
           ,PAYMENT_STATUS
           ,PAYMENT_PLAN
           ,ORDER_ID)
     VALUES
           (1003
           ,'2023-03-24'
           ,28.24
           ,'VISA'
           ,'Received'
           ,'Full'
           ,103)
;

INSERT INTO PAYMENTS
           (PAYMENT_ID
           ,PAYMENT_DATE
           ,AMOUNT
           ,PAYMENT_METHOD
           ,PAYMENT_STATUS
           ,PAYMENT_PLAN
           ,ORDER_ID)
     VALUES
           (1004
           ,'2023-03-25'
           ,174.00
           ,'Mastercard'
           ,'Pending'
           ,'Full'
           ,104)
;

INSERT INTO PAYMENTS
           (PAYMENT_ID
           ,PAYMENT_DATE
           ,AMOUNT
           ,PAYMENT_METHOD
           ,PAYMENT_STATUS
           ,PAYMENT_PLAN
           ,ORDER_ID)
     VALUES
           (1005
           ,'2023-03-25'
           ,27988.80
           ,'Cheque'
           ,'Cashed'
           ,'Full'
           ,109)
;










-- Functional SQL statements

-- Ref Number: 01
SELECT * FROM ARTICLE WHERE MSRP BETWEEN <price> AND <price>;

-- Ref Number: 02
SELECT * FROM ROOM WHERE ROOM_HEADLINE = <desired headline>;

-- Ref Number: 03
SELECT * FROM ARTICLE WHERE COLOR = <desired color>;

-- Ref Number: 04
SELECT * FROM ORDERS WHERE CUSTOMER_ID = <customer_id>;

-- Ref Number: 05
UPDATE ORDERS SET ORDER_STATUS = 'Cancelled' WHERE ORDER_STATUS = 'Processing' AND ORDER_ID = <order_ID>;



-- Informational queries

-- Ref Number: 06
SELECT MONTH(p.PAYMENT_DATE) AS MONTH,YEAR(p.PAYMENT_DATE) AS YEAR, SUM(p.AMOUNT) AS TOTAL_SALES
 FROM PAYMENTS p 
 WHERE YEAR(p.PAYMENT_DATE) = 2023
 GROUP BY MONTH,YEAR
 ORDER BY TOTAL_SALES DESC
 LIMIT 1;
 
 -- Ref Number: 07
 SELECT a.ARTICLE_NAME, od.QTY_ORDERED AS Quantity
 FROM ORDER_DETAILS od
 JOIN ARTICLE a ON a.ARTICLE_NUMBER = od.ARTICLE_NUMBER
 JOIN ORDERS o ON o.ORDER_ID = od.ORDER_ID
 WHERE o.ORDER_DATE BETWEEN '2023-01-01' AND '2023-02-31'
 ORDER BY Quantity DESC
 LIMIT 2;
 
 -- Ref Number: 08
 SELECT c.CUSTOMER_ID, c.CUSTOMER_FIRST_NAME+ ' '+ c.CUSTOMER_LAST_NAME AS CUSTOMER_NAME, COUNT (o.ORDER_ID) AS CANCELLED_ORDERS
 FROM CUSTOMERS c
 JOIN ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
 WHERE o.ORDER_STATUS = 'Cancelled'
 GROUP BY c.CUSTOMER_ID, c.CUSTOMER_FIRST_NAME, c.CUSTOMER_LAST_NAME
 ORDER BY CANCELLED_ORDERS DESC
 LIMIT 1;
 
 -- Ref Number: 09
 SELECT c.CUSTOMER_ID, c.CUSTOMER_FIRST_NAME+' '+c.CUSTOMER_LAST_NAME AS CUSTOMER_NAME, SUM(p.AMOUNT) AS ORDER_VALUE
 FROM CUSTOMERS c
 JOIN ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
 JOIN PAYMENTS p ON o.ORDER_ID = p.ORDER_ID
 GROUP BY c.CUSTOMER_ID, c.CUSTOMER_FIRST_NAME, c.CUSTOMER_LAST_NAME
 ORDER BY ORDER_VALUE DESC
 LIMIT 5;
 
 -- Ref Number: 10
 SELECT c.CUSTOMER_FIRST_NAME+' '+c.CUSTOMER_LAST_NAME AS CUSTOMER_NAME
  FROM CUSTOMERS c
  LEFT JOIN ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
  WHERE MONTH(o.ORDER_DATE) != 3 OR o.ORDER_DATE IS NULL AND YEAR(o.ORDER_DATE) =2023;
 
 -- Ref Number: 11
 SELECT a.ARTICLE_NUMBER, a.ARTICLE_NAME, AVG(od.QTY_ORDERED) AS AVERAGE_QUANTITY
 FROM ARTICLE a
 JOIN ORDER_DETAILS od ON a.ARTICLE_NUMBER = od.ARTICLE_NUMBER
 GROUP BY a.ARTICLE_NUMBER, a.ARTICLE_NAME
 ORDER BY AVERAGE_QUANTITY DESC;
 
 -- Ref Number: 12
 SELECT od.ORDER_ID,c.CUSTOMER_FIRST_NAME+' '+c.CUSTOMER_LAST_NAME AS NAME, t.ARTICLE_NUMBER, od.QTY_ORDERED,t.AVERAGE_ORDER_QUANTITY
 FROM ORDER_DETAILS od
 JOIN ORDERS o on od.ORDER_ID = o.ORDER_ID
 JOIN CUSTOMERS c on o.CUSTOMER_ID = c.CUSTOMER_ID
 JOIN (
     SELECT a.ARTICLE_NUMBER, AVG(od.QTY_ORDERED) AS AVERAGE_ORDER_QUANTITY
 	FROM ORDER_DETAILS AS od
 	JOIN ARTICLE a ON a.ARTICLE_NUMBER = od.ARTICLE_NUMBER
 	GROUP BY a.ARTICLE_NUMBER
 ) t ON t.ARTICLE_NUMBER = od.ARTICLE_NUMBER
 WHERE od.QTY_ORDERED > t.AVERAGE_ORDER_QUANTITY;
 
 -- Ref Number: 13
 SELECT p.PAYMENT_METHOD, COUNT(*) AS NUM_PAYMENTS, MAX(p.AMOUNT) AS MAX_ORDER_VALUE
 FROM PAYMENTS p
 GROUP BY p.PAYMENT_METHOD
 ORDER BY NUM_PAYMENTS DESC;
 
 -- Ref Number: 14
 SELECT a.ASSEMBLY_LEVEL, SUM(od.QTY_ORDERED) AS TOTAL_ORDERS
 FROM ARTICLE a
 JOIN ORDER_DETAILS od on od.ARTICLE_NUMBER = a.ARTICLE_NUMBER
 GROUP BY a.ASSEMBLY_LEVEL;
 
 -- Ref Number: 15
 SELECT 
 (CAST(SUM(CASE WHEN DISCOUNT = 1 THEN 1 ELSE 0 END) AS FLOAT)/COUNT(*)) AS DISCOUNTED_ORDER_PROPORTION,
 (CAST(SUM(CASE WHEN DISCOUNT = 0 THEN 1 ELSE 0 END) AS FLOAT)/COUNT(*)) AS NON_DISCOUNTED_ORDER_PROPORTION
 FROM ORDER_DETAILS;
 
 
 
 
 
 
 
 
 
 
 
 
-- Graph database Cypher creation statements

CREATE (R1:Room {ROOM_ID: 1, ROOM_HEADLINE: 'Bedroom'}),
(R2:Room {ROOM_ID: 2, ROOM_HEADLINE: 'Beds'}),
(R3:Room {ROOM_ID: 3, ROOM_HEADLINE: 'Tables'}),
(R4:Room {ROOM_ID: 4, ROOM_HEADLINE: 'Cabinets'}),
(R5:Room {ROOM_ID: 5, ROOM_HEADLINE: 'Shelving units'}),
(R6:Room {ROOM_ID: 6, ROOM_HEADLINE: 'King & queen beds'}),
(R7:Room {ROOM_ID: 7, ROOM_HEADLINE: 'Sofas & sofa beds'}),
(R8:Room {ROOM_ID: 8, ROOM_HEADLINE: 'Twin beds'}),
(R9:Room {ROOM_ID: 9, ROOM_HEADLINE: 'Bunk beds'}),
(R10:Room {ROOM_ID: 10, ROOM_HEADLINE: 'Desks'}),
(R11:Room {ROOM_ID: 11, ROOM_HEADLINE: 'Nightstands'}),
(R12:Room {ROOM_ID: 12, ROOM_HEADLINE: 'Side tables'}),
(R13:Room {ROOM_ID: 13, ROOM_HEADLINE: 'Dressers'}),
(R14:Room {ROOM_ID: 14, ROOM_HEADLINE: 'Armoires'}),
(R15:Room {ROOM_ID: 15, ROOM_HEADLINE: 'Sideboards'}),
(R16:Room {ROOM_ID: 16, ROOM_HEADLINE: 'Wall shelves'}),
(R17:Room {ROOM_ID: 17, ROOM_HEADLINE: 'Display units'}),
(R18:Room {ROOM_ID: 18, ROOM_HEADLINE: 'Bookcases'}),
(R19:Room {ROOM_ID: 19, ROOM_HEADLINE: 'Living room'}),
(R20:Room {ROOM_ID: 20, ROOM_HEADLINE: 'Chairs'}),
(R21:Room {ROOM_ID: 21, ROOM_HEADLINE: 'Sleeper sofas'}),
(R22:Room {ROOM_ID: 22, ROOM_HEADLINE: 'Leather sofas'}),
(R23:Room {ROOM_ID: 23, ROOM_HEADLINE: 'Sectional sofas'}),
(R24:Room {ROOM_ID: 24, ROOM_HEADLINE: 'Coffee tables'}),
(R25:Room {ROOM_ID: 25, ROOM_HEADLINE: 'Consoles'}),
(R26:Room {ROOM_ID: 26, ROOM_HEADLINE: 'Nesting tables'}),
(R27:Room {ROOM_ID: 27, ROOM_HEADLINE: 'Arm chairs'}),
(R28:Room {ROOM_ID: 28, ROOM_HEADLINE: 'Lounge chairs'}),
(R29:Room {ROOM_ID: 29, ROOM_HEADLINE: 'Ottomans & footstools'}),
(R30:Room {ROOM_ID: 30, ROOM_HEADLINE: 'Home office'}),
(R31:Room {ROOM_ID: 31, ROOM_HEADLINE: 'Writing desks'}),
(R32:Room {ROOM_ID: 32, ROOM_HEADLINE: 'Standing desks'}),
(R33:Room {ROOM_ID: 33, ROOM_HEADLINE: 'L-shaped desks'}),
(R34:Room {ROOM_ID: 34, ROOM_HEADLINE: 'Office chairs'}),
(R35:Room {ROOM_ID: 35, ROOM_HEADLINE: 'Gaming chairs'}),
(R36:Room {ROOM_ID: 36, ROOM_HEADLINE: 'Drawer units'}),
(R37:Room {ROOM_ID: 37, ROOM_HEADLINE: 'Filing cabinets'}),
(R38:Room {ROOM_ID: 38, ROOM_HEADLINE: 'Newspaper racks'}),
(R39:Room {ROOM_ID: 39, ROOM_HEADLINE: 'Noticeboards'}),
(R40:Room {ROOM_ID: 40, ROOM_HEADLINE: 'Magazine files'}),
(R1)-[:CONTAINS]->(R2),
(R1)-[:CONTAINS]->(R3),
(R1)-[:CONTAINS]->(R4),
(R1)-[:CONTAINS]->(R5),
(R2)-[:CONTAINS]->(R6),
(R2)-[:CONTAINS]->(R7),
(R2)-[:CONTAINS]->(R8),
(R2)-[:CONTAINS]->(R9),
(R3)-[:CONTAINS]->(R10),
(R3)-[:CONTAINS]->(R11),
(R3)-[:CONTAINS]->(R12),
(R4)-[:CONTAINS]->(R13),
(R4)-[:CONTAINS]->(R14),
(R4)-[:CONTAINS]->(R15),
(R5)-[:CONTAINS]->(R16),
(R5)-[:CONTAINS]->(R17),
(R5)-[:CONTAINS]->(R18),
(R19)-[:CONTAINS]->(R7),
(R19)-[:CONTAINS]->(R3),
(R19)-[:CONTAINS]->(R20),
(R19)-[:CONTAINS]->(R5),
(R7)-[:CONTAINS]->(R21),
(R7)-[:CONTAINS]->(R22),
(R7)-[:CONTAINS]->(R23),
(R3)-[:CONTAINS]->(R12),
(R3)-[:CONTAINS]->(R24),
(R3)-[:CONTAINS]->(R25),
(R3)-[:CONTAINS]->(R26),
(R20)-[:CONTAINS]->(R27),
(R20)-[:CONTAINS]->(R28),
(R20)-[:CONTAINS]->(R29),
(R5)-[:CONTAINS]->(R16),
(R5)-[:CONTAINS]->(R17),
(R5)-[:CONTAINS]->(R18),
(R30)-[:CONTAINS]->(R10),
(R30)-[:CONTAINS]->(R20),
(R30)-[:CONTAINS]->(R4),
(R30)-[:CONTAINS]->(R5),
(R10)-[:CONTAINS]->(R31),
(R10)-[:CONTAINS]->(R32),
(R10)-[:CONTAINS]->(R33),
(R20)-[:CONTAINS]->(R34),
(R20)-[:CONTAINS]->(R28),
(R20)-[:CONTAINS]->(R35),
(R4)-[:CONTAINS]->(R15),
(R4)-[:CONTAINS]->(R36),
(R4)-[:CONTAINS]->(R37),
(R5)-[:CONTAINS]->(R18),
(R5)-[:CONTAINS]->(R38),
(R5)-[:CONTAINS]->(R39),
(R5)-[:CONTAINS]->(R40)
RETURN R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40



-- Cypher queries

-- Ref Number: 16
MATCH (RX)-[C:CONTAINS]->(RY)
WITH RX.ROOM_HEADLINE as SUPER_ROOM, COUNT(DISTINCT RY.ROOM_HEADLINE) as ROOM_TYPE_COUNT
RETURN SUPER_ROOM, ROOM_TYPE_COUNT
ORDER BY ROOM_TYPE_COUNT DESC

-- Ref Number: 17
MATCH (RX)-[C:CONTAINS]->(RY)
WITH RY.ROOM_HEADLINE as ROOM_TYPE, COUNT(C) as SUPER_ROOM_COUNT
RETURN ROOM_TYPE, SUPER_ROOM_COUNT
ORDER BY SUPER_ROOM_COUNT DESC















