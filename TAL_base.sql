SELECT
	TransactionAccountingLine.Account AS Account,
	TransactionAccountingLine.Debit,
	TransactionAccountingLine.Credit,
	TransactionAccountingLine.Posting,
	TransactionLine.Memo,
	TransactionLine.Date_Closed
FROM
	TransactionAccountingLine
	INNER JOIN TransactionLine ON
		( TransactionLine.Transaction = TransactionAccountingLine. Transaction )
		AND ( TransactionLine.ID = TransactionAccountingLine. TransactionLine )
WHERE
	 ( ( TransactionAccountingLine.Debit IS NOT NULL ) 
		OR ( TransactionAccountingLine.Credit IS NOT NULL ))
