SELECT
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM(TransactionAccountingLine.Debit) As Debit,
	SUM (TransactionAccountingLine.Credit) AS Credit,
	TL.subsidiary
FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
WHERE
	( Transaction.Type = 'Journal' )
	AND (BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
GROUP BY
  TL.subsidiary,
  TransactionAccountingLine.Account
ORDER BY
	Transaction.ID DESC
  
  
SELECT
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Debit) As Debit,
	SUM (TransactionAccountingLine.Credit) AS Credit,
	S.Name
FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
	LEFT JOIN subsidiary S ON  S.id = TL.subsidiary
WHERE
	Transaction.Type = 'Journal' 
	AND (BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021' )
	AND (S.Name = '<SubsidiaryName>')
	
GROUP BY
  TL.subsidiary,
  BUILTIN.DF( TransactionAccountingLine.Account ),
  BUILTIN.DF( Transaction.PostingPeriod ),
  S.Name



