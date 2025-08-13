
CREATE DATABASE BANK_MANAGEMENT;


USE BANK_MANAGEMENT;


CREATE TABLE Account_opening_form (
    id INT PRIMARY KEY,
    Opening_Date DATETIME DEFAULT GETDATE(),
    Account_Type VARCHAR(20) DEFAULT 'Saving',
    Account_Holder_Name VARCHAR(100),
    Date_of_Birth DATETIME,
    Aadhar_No VARCHAR(12),
    Mobile_No BIGINT,  
    Account_Opening_Balance INT CHECK(Account_Opening_Balance >= 1000),
    Address VARCHAR(150),
    KYC_Status VARCHAR(50) DEFAULT 'Pending'
);

CREATE TABLE BANK (
    ACCOUNT_NUMBER INT IDENTITY(100001, 1) PRIMARY KEY,  
    ACCOUNT_TYPE VARCHAR(20),
    ACCOUNT_OPENING_DATE DATE,
    CURRENT_BALANCE DECIMAL(15, 2) DEFAULT 0.00,
    account_id INT,
    FOREIGN KEY (account_id) REFERENCES Account_opening_form(id)
);


CREATE TABLE ACCOUNT_HOLDER_DETAILS (
    ACCOUNT_NUMBER INT PRIMARY KEY,
    ACCOUNT_HOLDER_NAME VARCHAR(100),
    DOB DATE,
    AADHAR_NUMBER CHAR(12),
    MOBILE_NUMBER CHAR(15),
    FOREIGN KEY (ACCOUNT_NUMBER) REFERENCES BANK(ACCOUNT_NUMBER)
);

CREATE TABLE TRANSACTION_DETAILS (
    TRANSACTION_ID INT PRIMARY KEY,
    ACCOUNT_NUMBER INT,
    PAYMENT_TYPE VARCHAR(50),
    TRANSACTION_AMOUNT DECIMAL(15, 2),
    DATE_OF_TRANSACTION DATETIME DEFAULT GETDATE(), 
    FOREIGN KEY (ACCOUNT_NUMBER) REFERENCES BANK(ACCOUNT_NUMBER)
);




INSERT INTO Account_opening_form (
    id,
    Account_Holder_Name, 
    Date_of_Birth, 
    Aadhar_No, 
    Mobile_No, 
    Account_Opening_Balance, 
    Address
) 
VALUES (
    1,
    'Jane Doe', 
    '1985-05-15', 
    '987654321098', 
    '1234567890', 
    2000, 
    '456 Park Ave, City ABC'
);


INSERT INTO Account_opening_form (
    id,
    Account_Holder_Name, 
    Date_of_Birth, 
    Aadhar_No, 
    Mobile_No, 
    Account_Opening_Balance, 
    Address
) 
VALUES(
    2,
    'Lucky', 
    '2025-02-03', 
    '440607431298', 
    8269276060, 
    7000, 
    'Tikamgarh MP'
);

INSERT INTO Account_opening_form (
    id,
    Account_Holder_Name, 
    Date_of_Birth, 
    Aadhar_No, 
    Mobile_No, 
    Account_Opening_Balance, 
    Address
) 
VALUES(
    3,
    'Kunal', 
    '2004-02-03', 
    '440607431878', 
    8269278989, 
    1500, 
    'Punjab'
);


SELECT * FROM Account_opening_form;
SELECT * FROM BANK;
SELECT * FROM ACCOUNT_HOLDER_DETAILS;
SELECT * FROM TRANSACTION_DETAILS;

UPDATE Account_opening_form
SET KYC_Status = 'Approved'
WHERE Aadhar_No = '440607431298';

UPDATE Account_opening_form
SET KYC_Status = 'Approved'
WHERE Aadhar_No = '440607431878';
UPDATE Account_opening_form
SET KYC_Status = 'Approved'
where Aadhar_No = '987654321098';

SELECT * FROM BANK;
SELECT * FROM ACCOUNT_HOLDER_DETAILS;


SELECT *FROM TRANSACTION_DETAILS;

-- Example for Deposit transaction
INSERT INTO TRANSACTION_DETAILS (
    TRANSACTION_ID, 
    ACCOUNT_NUMBER, 
    PAYMENT_TYPE, 
    TRANSACTION_AMOUNT
) 
VALUES (
    1,  -- Assuming Account Number 1
    100001,  -- Account number to be updated
    'Deposit',  -- Transaction type
    500  -- Amount to deposit
);

-- Example for Withdrawal transaction
INSERT INTO TRANSACTION_DETAILS (
    TRANSACTION_ID, 
    ACCOUNT_NUMBER, 
    PAYMENT_TYPE, 
    TRANSACTION_AMOUNT
) 
VALUES (
    4,  -- Assuming Account Number 2
    100001,  -- Account number to be updated
    'Deposit',  -- Transaction type
    30000  -- Amount to withdraw
);
SELECT *FROM ACCOUNT_HOLDER_DETAILS
SELECT *from TRANSACTION_DETAILS;
Select *from BANK;
SELECT *FROM Account_opening_form;


INSERT INTO Account_opening_form (
    id,
    Account_Holder_Name, 
    Date_of_Birth, 
    Aadhar_No, 
    Mobile_No, 
    Account_Opening_Balance, 
    Address
) 
VALUES(
    4,
    'bhavya', 
    '2004-02-03', 
    '440607431838', 
    8269378989, 
    8000, 
    'Mathura UP'
);

Update Account_opening_form
SET KYC_Status = 'Approved'
where Aadhar_No = '440607431838'

INSERT INTO TRANSACTION_DETAILS (
    TRANSACTION_ID, 
    ACCOUNT_NUMBER, 
    PAYMENT_TYPE, 
    TRANSACTION_AMOUNT
) 
VALUES (
    5,  -- Assuming Account Number 2
    100004,  -- Account number to be updated
    'Deposit',  -- Transaction type
    13000 -- Amount to withdraw
);