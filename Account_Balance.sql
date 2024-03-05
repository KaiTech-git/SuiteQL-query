/*
Two queries that can be used to get accounts balance for for specific Entity/Subsidiary.
In NetSuite, PostingPeriod are absolute values calculated from some specific starting period which is why May 2021 
is assigned with value 193.
*/
SELECT
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Amount),
	 -- TransactionLine.Memo,
	Subsidiary.Name
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
	 AND( Transaction.PostingPeriod   <193 )  -- 'May2021'
	AND (  TransactionAccountingLine.Amount IS NOT NULL ) 
	AND  (TransactionAccountingLine.Posting = 'T')
	
GROUP BY
	BUILTIN.DF( TransactionAccountingLine.Account ),
	-- TransactionLine.Memo,
	Subsidiary.Name
----------SECOUND APPROACH
SELECT
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	SUM (TransactionAccountingLine.Amount),
	 -- TransactionLine.Memo,
	Subsidiary.Name
FROM
	TransactionAccountingLine
	INNER JOIN TransactionLine ON
		( TransactionLine.Transaction = TransactionAccountingLine. Transaction )
		AND ( TransactionLine.ID = TransactionAccountingLine. TransactionLine )
	 LEFT JOIN Transaction ON
		 (TransactionAccountingLine. Transaction = Transaction.ID)
	LEFT JOIN Subsidiary ON
		(Subsidiary.Id = TransactionLine.Subsidiary)
	LEFT JOIN accountingPeriod ON
		(accountingPeriod.id = Transaction.PostingPeriod)

WHERE
	( Subsidiary.Name = '<SubsidiaryName>')
	AND(  accountingPeriod.enddate <= '31/05/2021' )  -- 'May2021'
	AND (  TransactionAccountingLine.Amount IS NOT NULL ) 
	AND  (TransactionAccountingLine.Posting = 'T')
	
GROUP BY
	BUILTIN.DF( TransactionAccountingLine.Account ),
	-- TransactionLine.Memo,
	Subsidiary.Name
