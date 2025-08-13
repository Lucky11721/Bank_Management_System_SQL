-----------------------------------------TRIGGERS-------------------------------------

CREATE TRIGGER TR_FOR_INSERT_INTO_TRANSACTION_DETAILS
ON TRANSACTION_DETAILS
AFTER INSERT
AS
BEGIN
    DECLARE 
        @AccountNumber INT, 
        @TransactionAmount DECIMAL(15, 2),
        @PaymentType VARCHAR(50),
        @CurrentBalance DECIMAL(15, 2);

    -- Fetch values from the inserted record
    SELECT 
        @AccountNumber = ACCOUNT_NUMBER, 
        @TransactionAmount = TRANSACTION_AMOUNT, 
        @PaymentType = PAYMENT_TYPE
    FROM inserted;

    -- Fetch current balance of the account
    SELECT @CurrentBalance = CURRENT_BALANCE 
    FROM BANK 
    WHERE ACCOUNT_NUMBER = @AccountNumber;

    -- Check if the transaction is a deposit or withdrawal
    IF @PaymentType = 'Deposit'
    BEGIN
        -- Add the transaction amount to the current balance for Deposit
        UPDATE BANK
        SET CURRENT_BALANCE = @CurrentBalance + @TransactionAmount
        WHERE ACCOUNT_NUMBER = @AccountNumber;
    END
    ELSE IF @PaymentType = 'Withdrawal'
    BEGIN
        IF @CurrentBalance >= @TransactionAmount
        BEGIN
            UPDATE BANK
            SET CURRENT_BALANCE = @CurrentBalance - @TransactionAmount
            WHERE ACCOUNT_NUMBER = @AccountNumber;
        END
        ELSE
        BEGIN
            -- If insufficient balance, raise an error (optional)
            RAISERROR('Insufficient funds for withdrawal', 16, 1);
        END
    END
END;


CREATE TRIGGER TR_FOR_INSERT_INTO_ACC_OPENING_FORM
ON Account_opening_form
AFTER UPDATE
AS
BEGIN
    DECLARE 
        @status VARCHAR(50),
        @AccountType VARCHAR(20),
        @Account_HolderName VARCHAR(100),
        @DOB DATE,
        @AadharNumber CHAR(12),
        @MobileNumber CHAR(15),
        @Account_opening_balance DECIMAL(15, 2),
        @FullAddress VARCHAR(150),
        @AccountNumber INT,  -- This will store the auto-generated AccountNumber
        @AccountID INT;     -- Account ID from the Account_opening_form

    
    SELECT 
        @status = KYC_Status, 
        @AccountType = Account_Type, 
        @Account_HolderName = Account_Holder_Name,
        @DOB = Date_of_Birth, 
        @AadharNumber = Aadhar_No, 
        @MobileNumber = Mobile_No, 
        @Account_opening_balance = Account_Opening_Balance,
        @FullAddress = Address,
        @AccountID = id
    FROM inserted;

    
    IF @status = 'Approved'
    BEGIN
        
        INSERT INTO BANK (ACCOUNT_TYPE, ACCOUNT_OPENING_DATE, CURRENT_BALANCE, account_id) 
        VALUES (@AccountType, GETDATE(), @Account_opening_balance, @AccountID);

        
        SET @AccountNumber = SCOPE_IDENTITY();

      
        INSERT INTO ACCOUNT_HOLDER_DETAILS (ACCOUNT_NUMBER, ACCOUNT_HOLDER_NAME, DOB, AADHAR_NUMBER, MOBILE_NUMBER) 
        VALUES (@AccountNumber, @Account_HolderName, @DOB, @AadharNumber, @MobileNumber);
    END
END;

