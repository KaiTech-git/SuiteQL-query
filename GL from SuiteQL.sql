SELECT
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Debit),
	SUM (TransactionAccountingLine.Credit),
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
	AND ( ( TransactionAccountingLine.Debit IS NOT NULL ) 
		OR ( TransactionAccountingLine.Credit IS NOT NULL )
	)
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
