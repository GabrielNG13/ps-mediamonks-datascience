-- 1. Qual foi a receita de cada tipo de pagamento no dia 15 de Março de 2018?

SELECT
  (CASE payment_type
    WHEN '1' THEN 'Credit card'
    WHEN '2' THEN 'Cash'
    WHEN '3' THEN 'No charge'
    WHEN '4' THEN 'Dispute'
    WHEN '5' THEN 'Unknown'
    WHEN '6' THEN 'Voided trip'
  END) AS payment_type,
  SUM(total_amount) AS revenue
FROM TABELA
WHERE DATE(dropoff_datetime) = '2018-03-15'
GROUP BY payment_type
ORDER BY payment_type



-- 2. Considere que corridas de táxi válidas tenham de 1 a 5 passageiros. Qual a quantidade de corridas feitas com cada número de passageiros, faturamento médio de cada corrida e faturamento médio por passageiro?

SELECT
  passenger_count,
  COUNT(*) AS races_quantity,
  ROUND( AVG(total_amount), 2 ) AS average_revenue,
  ROUND( AVG(total_amount)/passenger_count, 2 ) AS average_revenue_per_passenger
FROM TABELA
WHERE passenger_count BETWEEN 1 AND 5
GROUP BY passenger_count
ORDER BY passenger_count



-- 3. Qual a hora que mais começaram corridas?

SELECT EXTRACT(HOUR FROM pickup_datetime) AS most_frequent_hour,
FROM TABELA
GROUP BY most_frequent_hour
ORDER BY COUNT(*) DESC
LIMIT 1
 


-- 4. Considerando apenas as corridas que houveram pedágios (tolls) e que transportaram até 3 passageiros, qual a média do valor pago em pedágios por corrida?

SELECT ROUND(AVG(tolls_amount), 2) AS average_tolls_amount,
FROM TABELA
WHERE tolls_amount > 0
  AND passenger_count <= 3