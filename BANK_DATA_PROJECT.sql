SELECT * FROM bank_domain.financial;
-- Dec month loan apllication
select distinct (extract(year from issue_date)) from financial;
SELECT 
    COUNT(id) AS total_loan_application,
    EXTRACT(MONTH FROM issue_date) AS month,
    EXTRACT(YEAR FROM issue_date) AS year
FROM
    financial
WHERE
    EXTRACT(MONTH FROM issue_date) = 12
;
-- month on month loan apllication
select * from financial;
SELECT 
    id AS total_loan_application,
    EXTRACT(MONTH FROM issue_date) AS month,
    EXTRACT(YEAR FROM issue_date) AS year
FROM
    financial
    group by month 
    order by month asc ;
-- PREVIOUS MONTH LOAN COUNT
SELECT 
    COUNT(id) AS total_loan_application,
    EXTRACT(MONTH FROM issue_date) AS month,
    EXTRACT(YEAR FROM issue_date) AS year
FROM
    financial
WHERE
    EXTRACT(MONTH FROM issue_date) = 11
;
-- TOTAL FUND AMOUNT
SELECT * FROM FINANCIAL;
SELECT SUM(LOAN_AMOUNT) FROM FINANCIAL;

SELECT SUM(LOAN_AMOUNT),EXTRACT(MONTH FROM issue_date) AS month 
FROM FINANCIAL
group by month
ORDER BY MONTH ASC
;
-- DECEMBER MONTH LOAN AMOUNT ISSUE
SELECT SUM(LOAN_AMOUNT),EXTRACT(MONTH FROM issue_date) AS month 
FROM FINANCIAL
WHERE EXTRACT(MONTH FROM issue_date)=12;
-- PREVIOUS MONTH TOTAL FUND AMOUNT
SELECT SUM(LOAN_AMOUNT),EXTRACT(MONTH FROM issue_date) AS month 
FROM FINANCIAL
WHERE EXTRACT(MONTH FROM issue_date)=11
;
-- TOTAL MOUNT RECEIVED MONTH WISE ,
SELECT * FROM FINANCIAL;
SELECT SUM(TOTAL_PAYMENT),
		EXTRACT(MONTH FROM issue_date) AS month
		FROM FINANCIAL
		group by MONTH
		ORDER BY SUM(TOTAL_PAYMENT) ASC
        LIMIT 5
;
-- AVERAGE INTEREST RATE
SELECT * FROM FINANCIAL;
select AVG(INT_RATE)*100 FROM FINANCIAL;
-- MONTH WISE INTERREST RATE
SELECT ROUND(AVG(INT_RATE)*100,3) AS LOWEST_INT_RATE,
		EXTRACT(MONTH FROM issue_date) AS month
		FROM FINANCIAL
		group by MONTH
		ORDER BY AVG(INT_RATE)*100 ASC
        LIMIT 1
        ;
-- AVG DTI
SELECT * FROM FINANCIAL;
SELECT ROUND(AVG(DTI)*100,3) FROM FINANCIAL;
-- MONTH WISE
SELECT ROUND(AVG(DTI)*100,3),EXTRACT(MONTH FROM issue_date) AS month
 FROM FINANCIAL
 group by MONTH
 ORDER BY MONTH ASC;
-- GOOD LOAN ISSUED
-- GOOD LOAN PERCENTAGE
SELECT * FROM FINANCIAL;
--  "Charge off" in the context of loans typically means that the loan holder is unable to repay the loan, 
-- and as a result, the lender (usually a bank or financial institution) 
-- writes off the remaining loan amount as a loss or bad debt..
select DISTINCT LOAN_STATUS FROM FINANCIAL;
SELECT * FROM FINANCIAL
WHERE LOAN_STATUS ='CHARGED OFF';

-- GOOD LOAN ( LOAN_SATUS IS FULLY PAID OR CURRENT)
SELECT * FROM FINANCIAL;
SELECT 
    (COUNT(CASE
        WHEN
            LOAN_STATUS = 'FULLY PAID'
                OR LOAN_STATUS = 'CURRENT'
        THEN
            ID
    END) / COUNT(ID)) * 100 AS GOOD_LOAN_PERCENTAGE
FROM
    FINANCIAL;

-- GOOD LOAN APPLICANT

SELECT COUNT(ID) GOOD_LOAN_APPLICANT FROM FINANCIAL
WHERE LOAN_STATUS = 'FULLY PAID'
                OR LOAN_STATUS = 'CURRENT';
-- GOOD LOAN AMOUNT
SELECT * FROM FINANCIAL;
SELECT SUM(LOAN_AMOUNT)  AS GOOD_LOAN_AMOUNT FROM FINANCIAL
 WHERE LOAN_STATUS = 'FULLY PAID'
	   OR LOAN_STATUS = 'CURRENT';

-- 
-- DIFF_GOOD_BAD
SELECT SUM(CASE WHEN LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT'THEN TOTAL_PAYMENT END) AS  GOOD_LOAN_AMOUNT  ,
SUM(CASE WHEN LOAN_STATUS != 'FULLY PAID' OR LOAN_STATUS != 'CURRENT'THEN TOTAL_PAYMENT END) AS  BAD_LOAN_AMOUNT,
( SUM(CASE WHEN LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT'THEN TOTAL_PAYMENT END) - 
 SUM(CASE WHEN LOAN_STATUS != 'FULLY PAID' OR LOAN_STATUS != 'CURRENT'THEN TOTAL_PAYMENT END))
 AS DIFF_GOOD_BAD
FROM FINANCIAL;

-- GOOD LOAN AMOUNT RECEIVED
SELECT SUM(CASE WHEN LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT'THEN TOTAL_PAYMENT END) AS  GOOD_LOAN_AMOUNT_RECEIVED  FROM FINANCIAL
;
-- BAD LOAN ISSUED

-- Bad Loan Percentage
SELECT COUNT(CASE WHEN LOAN_STATUS != 'FULLY PAID' AND LOAN_STATUS != 'CURRENT'THEN ID END) 
-- / COUNT(ID))*100 AS  BAD_LOAN_PERCENTAGE
FROM FINANCIAL;
-- BAD LOAN COUNT
SELECT COUNT(CASE WHEN LOAN_STATUS != 'FULLY PAID' AND LOAN_STATUS != 'CURRENT'THEN ID END) AS BAD_LOAN_COUNT
-- / COUNT(ID))*100 AS  BAD_LOAN_PERCENTAGE
FROM FINANCIAL;
-- BAD LOAN AMOUNT
SELECT * FROM FINANCIAL;
SELECT SUM(CASE WHEN LOAN_STATUS != 'FULLY PAID' AND LOAN_STATUS != 'CURRENT'THEN TOTAL_PAYMENT END) AS BAD_LOAN_AMOUNT
FROM FINANCIAL;

-- LOAN STATUS
SELECT * FROM FINANCIAL;
SELECT LOAN_STATUS,
		COUNT(ID),
        SUM(LOAN_AMOUNT) AS TOTAL_AMOUNT_GIVEN,
        SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECEIVED
        FROM FINANCIAL
        GROUP BY LOAN_STATUS;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status
;
-- B.	
-- BANK LOAN REPORT | OVERVIEW
-- MONTH
select * from financial;
select  
extract(month from issue_date) as month,
count(id) as no_of_application,
monthname(issue_date) as month_name,
sum(loan_amount) as total_amount_loan,
sum(total_payment)as total_amount_received
from financial
group by extract(month from issue_date)
order by extract(month from issue_date) asc
;
-- state
select * from financial;
-- purpose of loan
select purpose,count(purpose) from financial
group by purpose
order by count(purpose) desc ;
-- percentage_distribution of purpose
SELECT 
    purpose,
    COUNT(purpose) AS purpose_count,
    (COUNT(purpose) * 100.0) / SUM(COUNT(purpose)) OVER () AS percentage_distribution
FROM 
    financial
GROUP BY 
    purpose
ORDER BY 
    purpose_count DESC;
-- state wise distribution 551 recordes
select * from financial;
select address_state,  
-- extract(month from issue_date) as month,
count(id) as no_of_application,
-- monthname(issue_date) as month_name,
sum(loan_amount) as total_amount_loan,
sum(total_payment)as total_amount_received
from financial
group by address_state
-- ,extract(month from issue_date)
order by address_state asc
;
-- term wise funded amount
select count(id),term ,
sum(loan_amount) as total_amount_loan,
sum(total_payment)as total_amount_received
from financial
group by term
order by term ;
-- employee length 11 records
select * from financial;
select count(id),emp_length ,
sum(loan_amount) as total_amount_loan,
sum(total_payment)as total_amount_received
from financial
group by emp_length
order by emp_length ;
-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial
GROUP BY home_ownership
ORDER BY home_ownership;
-- grade A loan 14 recordes
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
;

        