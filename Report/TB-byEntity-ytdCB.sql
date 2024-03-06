/* Example for Oct 2021 tested on SB2 Change on the account */


SELECT  
  A.acctnumber AS AccountNumber, 
  A.fullname AS AccountName,
  SUM(TAL.amount) AS ClosingBalance,
 BUILTIN.DF(S.currency) As Currency,
 S.name As Subsidiary

FROM transactionaccountingline TAL 
INNER JOIN transaction T
  ON T.id = TAL.transaction
LEFT JOIN account A 
  ON TAL.account = A.id
LEFT JOIN transactionline TL
  ON TL.transaction = TAL.transaction
LEFT JOIN accountingperiod AP
  ON T.postingperiod = AP.id
LEFT JOIN subsidiary S
  ON S.id = TL.subsidiary
WHERE  /*Internal ID of the subsidiary that the report should be generated for*/
  TAL.posting = 'T' AND
  (TAL.accountingbook = 1) AND
  ((A.accttype IN ('Income', 'Expense', 'OthIncome', 'OthExpense', 'COGS') AND
    AP.enddate < TO_DATE('20211101', 'YYYYMMDD') AND /*20210901 for Aug 2021*/
    AP.startdate > TO_DATE('20201231', 'YYYYMMDD') /*20210331 for April-March Fiscal Calendar 2021*/
  ) OR
  (A.accttype NOT IN ('Income', 'Expense', 'OthIncome', 'OthExpense', 'COGS') AND
    AP.enddate < TO_DATE('20211101', 'YYYYMMDD') /*20210901 for Aug 2021*/
  )) AND
  TL.id = TAL.transactionline AND
  A.acctnumber <> '4040000002' /*Account Number of the Retained Earnings Account which is calculated separately.*/
GROUP BY A.acctnumber,
  A.fullname,
 BUILTIN.DF(S.currency),
 S.name
HAVING SUM(TAL.amount) <> 0


UNION 
SELECT  
  '4040000002' AS AccountNumber, 
  'Capital and Reserves - P&L account Current Period' AS AccountName,
  SUM(-TAL.amount) AS ClosingBalance,
 BUILTIN.DF(S.currency) As Currency,
 S.name As Subsidiary

FROM transactionaccountingline TAL 
INNER JOIN transaction T
  ON T.id = TAL.transaction
LEFT JOIN account A 
  ON TAL.account = A.id
LEFT JOIN transactionline TL
  ON TL.transaction = TAL.transaction
LEFT JOIN accountingperiod AP
  ON T.postingperiod = AP.id
LEFT JOIN subsidiary S
  ON S.id = TL.subsidiary
WHERE  /*Internal ID of the subsidiary that the report should be generated for*/
  TAL.posting = 'T' AND
  (TAL.accountingbook = 1) AND
  ((A.accttype IN ('Income', 'Expense', 'OthIncome', 'OthExpense', 'COGS') AND
    AP.enddate < TO_DATE('20211101', 'YYYYMMDD') AND /*20210901 for Aug 2021*/
    AP.startdate > TO_DATE('20201231', 'YYYYMMDD') /*20210331 for April-March Fiscal Calendar 2021*/
  ) OR
  (A.accttype NOT IN ('Income', 'Expense', 'OthIncome', 'OthExpense', 'COGS') AND
     AP.enddate < TO_DATE('20211101', 'YYYYMMDD')  /*20210901 for Aug 2021*/
  )) AND
  TL.id = TAL.transactionline AND
  A.acctnumber <> '4040000002' /*Account Number of the Retained Earnings Account which is calculated separately.*/
GROUP BY '4040000002',
  'Capital and Reserves - P&L account Current Period',
 BUILTIN.DF(S.currency),
 S.name
HAVING SUM(TAL.amount) <> 0
