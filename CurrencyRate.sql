SELECT id
, BUILTIN.DF (basecurrency)
, BUILTIN.DF (transactioncurrency)
, effectivedate
, exchangerate
FROM currencyRate

WHERE
effectivedate >= '1/10/2021'
AND effectivedate<='31/10/2021'

---xlsx SQL---

SELECT id
, BUILTIN.DF (basecurrency)
, BUILTIN.DF (transactioncurrency)
, effectivedate
, exchangerate
FROM currencyRate

WHERE
effectivedate >= {ts '2021-10-01 00:00:00'}
AND effectivedate<={ts '2021-10-31 00:00:00'}
ORDER BY effectivedate DESC , basecurrency DESC , transactioncurrency DESC , id DESC 
