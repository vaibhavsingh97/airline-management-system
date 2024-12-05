/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

SELECT 
    EXTRACT(YEAR FROM period_start) AS year,
    EXTRACT(MONTH FROM period_start) AS month,
    total_cashflow,
    LAG(total_cashflow) OVER (PARTITION BY EXTRACT(MONTH FROM period_start) ORDER BY period_start) AS prev_year_cashflow,
    total_cashflow - LAG(total_cashflow) OVER (PARTITION BY EXTRACT(MONTH FROM period_start) ORDER BY period_start) AS yoy_difference
FROM Incoming_Cashflow
WHERE time_period = 'Monthly'
ORDER BY period_start;