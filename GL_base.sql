/* Journal Entries*/
SELECT
	Transaction.ID,
	Transaction.TranID,
	Transaction.TranDate,
	BUILTIN.DF( Transaction.PostingPeriod ) AS PostingPeriod,
	Transaction.Memo,
	Transaction.Posting,
	BUILTIN.DF( Transaction.Status ) AS Status,
	BUILTIN.DF( Transaction.CreatedBy ) AS CreatedBy
FROM
	Transaction
WHERE
	( Transaction.Type = 'Journal' )
	AND ( Transaction.TranDate BETWEEN TO_DATE( '2021-05-01', 'YYYY-MM-DD' ) AND TO_DATE( '2021-05-31', 'YYYY-MM-DD' ) )
ORDER BY
	Transaction.ID DESC
    
/* GL FROM TAL*/

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
	TransactionAccountingLine.Credit
FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
WHERE
	( Transaction.Type = 'Journal' )
	AND ( Transaction.TranDate BETWEEN TO_DATE( '2021-05-01', 'YYYY-MM-DD' ) AND TO_DATE( '2021-05-31', 'YYYY-MM-DD' ) )
ORDER BY
	Transaction.ID DESC
    
/* GL FROM TAL by sub*/
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
	TL.subsidiary
FROM
	Transaction
	INNER JOIN TransactionAccountingLine ON
		( TransactionAccountingLine.Transaction = Transaction.ID )
	LEFT JOIN transactionline TL ON 
		(TL.transaction = Transaction.ID)
WHERE
	( Transaction.Type = 'Journal' )
	AND ( Transaction.TranDate BETWEEN TO_DATE( '2021-05-01', 'YYYY-MM-DD' ) AND TO_DATE( '2021-05-31', 'YYYY-MM-DD' ) )
ORDER BY
	Transaction.ID DESC
