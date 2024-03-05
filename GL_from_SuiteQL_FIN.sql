SELECT
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Amount),
	TransactionAccountingLine.Posting,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	 -- TransactionLine.Memo,
	Subsidiary.Name,
	TransactionLine.Transaction,
	Transaction.Tranid
FROM
	TransactionAccountingLine
	INNER JOIN TransactionLine ON
		( TransactionLine.Transaction = TransactionAccountingLine. Transaction )
		AND ( TransactionLine.ID = TransactionAccountingLine. TransactionLine )
	 LEFT JOIN Transaction ON
		 (TransactionAccountingLine. Transaction = Transaction.ID)
	LEFT JOIN Subsidiary ON
		(Subsidiary.Id = TransactionLine.Subsidiary)

WHERE
	( Subsidiary.Name = '<SubsidiaryName>')
	AND (BUILTIN.DF( Transaction.PostingPeriod )  = 'May 2021')
	AND (  TransactionAccountingLine.Amount IS NOT NULL ) 
	AND  (TransactionAccountingLine.Posting = 'T')
	
GROUP BY
	BUILTIN.DF( TransactionAccountingLine.Account ),
	TransactionLine.Transaction,
	BUILTIN.DF( Transaction.PostingPeriod ),
	-- TransactionLine.Memo,
	Subsidiary.Name,
	TransactionLine.Transaction,
	Transaction.Tranid,
	TransactionAccountingLine.Posting
Having
	SUM (TransactionAccountingLine.Amount) <> 0
	
---- + Accounting book selection SB2
SELECT
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Amount),
	TransactionAccountingLine.Posting,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	 -- TransactionLine.Memo,
	Subsidiary.Name,
	TransactionLine.Transaction,
	Transaction.Tranid
FROM
	TransactionAccountingLine
	INNER JOIN TransactionLine ON
		( TransactionLine.Transaction = TransactionAccountingLine. Transaction )
		AND ( TransactionLine.ID = TransactionAccountingLine. TransactionLine )
	 LEFT JOIN Transaction ON
		 (TransactionAccountingLine. Transaction = Transaction.ID)
	LEFT JOIN Subsidiary ON
		(Subsidiary.Id = TransactionLine.Subsidiary)

WHERE
	( Subsidiary.Name = 'WRRW')
	AND (BUILTIN.DF( Transaction.PostingPeriod )  = 'Jan 2022')
	AND (  TransactionAccountingLine.Amount IS NOT NULL ) 
	AND  (TransactionAccountingLine.Posting = 'T')
	AND (TransactionAccountingLine.accountingbook=1)
	
GROUP BY
	BUILTIN.DF( TransactionAccountingLine.Account ),
	TransactionLine.Transaction,
	BUILTIN.DF( Transaction.PostingPeriod ),
	-- TransactionLine.Memo,
	Subsidiary.Name,
	TransactionLine.Transaction,
	Transaction.Tranid,
	TransactionAccountingLine.Posting
Having
	SUM (TransactionAccountingLine.Amount) <> 0

