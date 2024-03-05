
SELECT
	Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	S.Name

FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
	LEFT JOIN subsidiary S ON  
		S.id = TL.subsidiary

WHERE
	( Transaction.Type = 'Journal' )
	AND ( BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
	AND (S.Name = '<SubsidiaryName>')
ORDER BY
	Transaction.ID DESC

////
SELECT
	Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	S.Name

FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
	LEFT JOIN subsidiary S ON  
		S.id = TL.subsidiary

WHERE
	( Transaction.Type = 'Journal' )
	AND ( BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
	AND (S.Name = '<SubsidiaryName>')
	AND (Transaction.Posting = 'T')
ORDER BY
	Transaction.ID DESC
	
SELECT
	DISTINCT Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	S.Name

FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
	LEFT JOIN subsidiary S ON  
		S.id = TL.subsidiary

WHERE
	( Transaction.Type = 'Journal' )
	AND ( BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
	AND (S.Name = '<SubsidiaryName>)')
	AND (Transaction.Posting = 'T')
	AND ( ( TransactionAccountingLine.Debit IS NOT NULL ) 
		OR ( TransactionAccountingLine.Credit IS NOT NULL ))

ORDER BY
	Transaction.ID DESC
	
	
	///
	SELECT
	DISTINCT Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	S.Name,
	Transaction.intercostatus

FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
	LEFT JOIN subsidiary S ON  
		S.id = TL.subsidiary

WHERE
 ( BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
	AND (S.Name = '<SubsidiaryName>')
	AND (Transaction.Posting = 'T')
	AND ( ( TransactionAccountingLine.Debit IS NOT NULL ) 
		OR ( TransactionAccountingLine.Credit IS NOT NULL ))

ORDER BY
	Transaction.ID DESC
	
///FINAL GL

	SELECT
	Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy,
	BUILTIN.DF( TransactionAccountingLine.Account ) AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	S.Name,
	Transaction.intercostatus

FROM
	Transaction
	LEFT JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID AND TL.expenseaccount = TransactionAccountingLine.Account )
	LEFT JOIN subsidiary S ON  
		S.id = TL.subsidiary

WHERE
 ( BUILTIN.DF( Transaction.PostingPeriod ) = 'May 2021')
	AND (S.Name = '<SubsidiaryName>')
	AND (Transaction.Posting = 'T')
	AND ( ( TransactionAccountingLine.Debit IS NOT NULL ) 
		OR ( TransactionAccountingLine.Credit IS NOT NULL ))

ORDER BY
	Transaction.ID DESC

